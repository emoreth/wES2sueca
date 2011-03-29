class Carta

  NAIPES = ["ouros", "espadas", "paus", "copas"]
  NUMEROS = ["A", "7", "K", "J", "Q", "6", "5", "4", "3", "2"]
  
  attr_accessor :naipe, :numero

  def initialize(attributes = {})
    self.naipe = attributes[:naipe]
    self.numero = attributes[:numero]
  end

  def ==(other)
    self.naipe == other.naipe &&
      self.numero == other.numero
  end
end
