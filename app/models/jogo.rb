class Jogo

  attr_reader :duplas
  attr_reader   :primeiro_jogador
  attr_reader   :jogador_atual

  def initialize(dupla1, dupla2)
    @duplas = [dupla1, dupla2]
    @jogadores = [dupla1.jogadores[0], dupla2.jogadores[0], dupla1.jogadores[1], dupla2.jogadores[1]]
  end

  def distribuir_cartas
    baralho = Baralho.new
    baralho.embaralhar
    duplas.each do |dupla|
      dupla.jogadores.each do |jogador|
        jogador.receber_cartas baralho.comprar
      end
    end
  end

  def sortear_jogador
    duplas.sample.jogadores.sample
  end

  def escolher_primeiro
    @primeiro_jogador = sortear_jogador
    @jogador_atual = @primeiro_jogador
  end

  def proximo_jogador
    @jogador_atual = @jogadores[(@jogadores.index(@jogador_atual) + 1) % @jogadores.size]
  end
end
