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
#    breakpoint
    info = nil
    jogador = session[:jogo].jogador_atual
    if jogador.ia?
      info = {}
      info[:numero_carta] = jogador.proxima_jogada.id
      session[:jogo].proximo_jogador
    else
      if params[:numero_carta] && params[:numero_carta].any?
        jogador.cartas.select { |carta| carta == params[:numero_carta] }.first.jogar!
        session[:jogo].proximo_jogador
      end
    end
    render :json => { 
      :computador => info
    }, :layout => false

  end

end
