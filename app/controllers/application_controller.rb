class ApplicationController < ActionController::Base
  

	def index
		@jogador1 = Jogador.new
		@jogador2 = JogadorIA.new
		@jogador3 = JogadorIA.new
		@jogador4 = JogadorIA.new

		@dupla1 = Dupla.new @jogador1, @jogador3
		@dupla2 = Dupla.new @jogador2, @jogador4

		@jogo = Jogo.new @dupla1, @dupla2
		@jogo.nova_partida
    session[:jogo] = @jogo

	end

  def proxima_jogada
    info = nil
    if jogo.jogador_atual.ia?
      info = jogador_ia
    else
      jogador_humano
    end
   
    render :json => {
      :computador => info,
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
      info
    else
      nil
    end
  end

  def jogador_humano
    if params[:numero_carta] && params[:numero_carta].any?
      carta = jogo.jogador_atual.cartas.select { |carta| carta == params[:numero_carta] }.first
      if jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))
        jogador_ia
      end
    end
  end

  def jogo
    session[:jogo]
  end

end
