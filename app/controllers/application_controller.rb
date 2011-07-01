class ApplicationController < ActionController::Base
  

  def index
    @jogador1 = Jogador.new 0
    @jogador2 = JogadorIA.new 1
    @jogador3 = JogadorIA.new 2
    @jogador4 = JogadorIA.new 3

    @dupla1 = Dupla.new @jogador1, @jogador3
    @dupla2 = Dupla.new @jogador2, @jogador4

    @jogo = Jogo.new @dupla1, @dupla2
    @jogador2.jogo = @jogo
    @jogador3.jogo = @jogo
    @jogador4.jogo = @jogo
    @jogo.nova_partida
    session[:jogo] = @jogo

	end

  def proxima_jogada
    
    jogo.dificuldade = params[:game_level] if params[:game_level]
    @info = nil
    if jogo.jogador_atual.ia?
      jogador_ia
    else
      jogador_humano
    end
   
    render :json => {
      :computador => @info,
      :trunfo => jogo.partida_atual.trunfo.nome_arquivo,
      :jogador_atual => jogo.jogador_atual.id,
      :jogo_completo => jogo.completo?,
      :partida_nova => jogo.partida_nova?,
      :rodada_nova => jogo.rodada_nova?,
      :pontos_jogo_dupla_1 => jogo.duplas[0].pontos_do_jogo,
      :pontos_jogo_dupla_2 => jogo.duplas[1].pontos_do_jogo
    }, :layout => false
  
  end

  private
  def jogador_ia
    puts "jogador da ia numero #{jogo.jogador_atual.id}"
    carta = jogo.jogador_atual.proxima_jogada(jogo.partida_atual.rodada_atual.naipe)
    jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))
      info = {}
      info[:numero_carta] = carta.id
      info[:imagem_carta] = carta.nome_arquivo
      @info = info
#      jogo.jogador_atual.jogar_carta(carta)
      carta.jogar!
  end

  def jogador_humano
    puts "caralho nao passei nada!!!" unless params[:numero_carta]
    puts ">" * 30 if params[:numero_carta]
    puts "passei com a carta #{params[:numero_carta]}!!!" if params[:numero_carta]
    puts ">" * 30 if params[:numero_carta]
    if params[:numero_carta] && params[:numero_carta].any?
      carta = jogo.jogador_atual.cartas.select { |cada_carta| cada_carta.id == params[:numero_carta] }.first
      puts "--- Carta Jogada pelo Humano #{carta}"
      if carta.nil?
        carta = jogo.jogador_atual.cartas.first
      end
      if jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))
        if jogo.jogador_atual.ia?
          return jogador_ia
        else
          return jogador_humano
        end
      end
    end
    @info = nil
  end

  def jogo
    session[:jogo]
  end

end
