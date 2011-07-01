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
    #        breakpoint
    info = nil
    if jogo.jogador_atual.ia?
      info = jogador_ia
    else
      jogador_humano
    end
   
    render :json => {
      :computador => info,
      :trunfo => jogo.partida_atual.trunfo.nome_arquivo,
      :jogador_atual => jogo.jogador_atual.id
    }, :layout => false

  end

  private
  def jogador_ia
    carta = jogo.jogador_atual.proxima_jogada
    if jogo.jogar(carta)
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
      if jogo.jogar(carta)
        jogador_ia
      end
    end
  end

  def jogo
    session[:jogo]
  end

end
