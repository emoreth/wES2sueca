class ApplicationController < ActionController::Base
  

	def index
		@jogador1 = Jogador.new
		@jogador2 = JogadorIA.new
		@jogador3 = JogadorIA.new
		@jogador4 = JogadorIA.new

		@dupla1 = Dupla.new @jogador1, @jogador3
		@dupla2 = Dupla.new @jogador2, @jogador4

		@jogo = Jogo.new @dupla1, @dupla2
		@jogo.distribuir_cartas
    session[:jogo] = @jogo

	end

  def proxima_jogada

    info = nil
    jogador = session[:jogo].jogador_atual
    if jogador.ia?
      info = {}
      info[:numero_carta] = jogador.proxima_jogada.id
    else
      info  = nil
    end
    session[:jogo].proximo_jogador
    render :json => { 
      :computador => info
    }, :layout => false

  end

  def jogador_humano
    if params[:numero_carta] && params[:numero_carta].any?
      carta = jogo.jogador_atual.cartas.select { |carta| carta == params[:numero_carta] }.first
      if jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))
        jogador_ia
      end
    end
  end
end
