class Carta

  NAIPES = ["ouros", "espadas", "paus", "copas"]
  NUMEROS = ["A", "7", "K", "J", "Q", "6", "5", "4", "3", "2"]
  
  attr_accessor :naipe, :numero

  def initialize(attributes = {})
    @naipe = attributes[:naipe]
    @numero = attributes[:numero]
  end

  def ==(other)
    @naipe == other.naipe &&
      @numero == other.numero
  end
end
