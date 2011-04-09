class Jogo

  attr_accessor :duplas

  def initialize(dupla1, dupla2)
    self.duplas = [dupla1, dupla2]
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
end
