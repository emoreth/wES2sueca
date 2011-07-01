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
    puts params[:game_level] if params[:game_level]
    
    jogo.dificuldade = params[:game_level] if params[:game_level]

    @info = nil
    puts ">" * 10
    puts jogo.jogador_atual.id
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
    carta = jogo.jogador_atual.proxima_jogada(jogo.partida_atual.rodada_atual.naipe)
    if jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))
      info = {}
      info[:numero_carta] = carta.id
      info[:imagem_carta] = carta.nome_arquivo
      @info = info
    end
  end

  def jogador_humano
    if params[:numero_carta] && params[:numero_carta].any?
      carta = jogo.jogador_atual.cartas.select { |cada_carta| cada_carta == params[:numero_carta] }.first
      if jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))

#        if jogo.jogador_atual.ia?
#          jogador_ia
#        end
      end
    end
  end

  def jogo
    session[:jogo]
  end

end
