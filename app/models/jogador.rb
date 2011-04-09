class Jogador

  attr_accessor :cartas

  def initialize
    self.cartas = []
  end

  def receber_carta(carta)
    raise ArgumentError, "jogador deve ter no máximo 10 cartas" if self.cartas.length == 10
    self.cartas << carta
  end

  def receber_cartas(cartas)
    raise ArgumentError, "jogador deve ter no máximo 10 cartas" if (self.cartas.length + cartas.length) > 10
                self.cartas += cartas
      end

  def jogar_carta(carta)
    raise ArgumentError, "não há cartas para jogar" if self.cartas.empty?
    self.cartas.delete carta
  end
end
