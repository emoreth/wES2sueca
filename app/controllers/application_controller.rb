class ApplicationController < ActionController::Base
  

	def index
		@jogador1 = Jogador.new
		@jogador2 = Jogador.new
		@jogador3 = Jogador.new
		@jogador4 = Jogador.new

		@dupla1 = Dupla.new @jogador1, @jogador3
		@dupla2 = Dupla.new @jogador2, @jogador4

		@jogo = Jogo.new @dupla1, @dupla2
		@jogo.distribuir_cartas	

	end

  def proxima_jogada

    info = nil
    computador = true # Usar funçao de selecao
    if computador
      info = {}
      info[:numero_jogador] = 1
      info[:numero_carta] = 0
      info[:valor_carta] = "ca"
    end
    render :json => { 
      :computador => info
      }, :layout => false

  end

end
