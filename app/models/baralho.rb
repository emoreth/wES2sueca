class Baralho

  attr_accessor :cartas

  def initialize
    @cartas = []
    Carta::NAIPES.each do |naipe|
      Carta::NUMEROS.each do |numero|
        @cartas << Carta.new( :naipe => naipe, :numero => numero )
      end
    end
  end

  def embaralhar
    @cartas.shuffle!
    self
  end

  def comprar
    @cartas.pop 10
  end
end