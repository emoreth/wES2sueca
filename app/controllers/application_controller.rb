class ApplicationController < ActionController::Base
  

	def index
		@jogador1 = Jogador.new
		@jogador2 = Jogador.new
		@jogador3 = Jogador.new
		@jogador4 = Jogador.new

		@dupla1 = Dupla.new @jogador1, @jogador3
		@dupla2 = Dupla.new @jogador2, @jogador4

		@jogo=Jogo.new @dupla1, @dupla2
		@jogo.distribuir_cartas	
	end

end
