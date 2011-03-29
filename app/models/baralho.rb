class Baralho

  attr_accessor :cartas

  def initialize
    self.cartas = []
    Carta::NAIPES.each do |naipe|
      Carta::NUMEROS.each do |numero|
        self.cartas << Carta.new( :naipe => naipe, :numero => numero )
      end
    end
  end

  def embaralhar
    self.cartas.shuffle!
    self
  end

  def comprar
    self.cartas.pop
  end
end