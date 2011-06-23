class Baralho

  attr_reader :cartas

  def initialize
    @cartas = []
    Carta::NAIPES.each do |naipe|
      Carta::NUMEROS.each do |numero|
        @cartas << Carta.new( :naipe => naipe, :numero => numero )
      end
    end
    @cartas.shuffle!
    @cartas.each_with_index { |carta,index| carta.id = index.to_s }
  end

  def comprar
    @cartas.pop 10
  end
end
