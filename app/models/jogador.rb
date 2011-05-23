class Jogador

  attr_reader :cartas

  def initialize
    @cartas = []
  end

  def receber_cartas(cartas)
    raise ArgumentError, "jogador deve ter no máximo 10 cartas" if (@cartas.length + cartas.length) > 10
    @cartas += cartas
  end

  def jogar_carta(carta)
    raise ArgumentError, "não há cartas para jogar" if @cartas.empty?
    @cartas.delete carta
  end
end
