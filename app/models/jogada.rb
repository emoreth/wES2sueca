class Jogada

  attr_reader :jogador, :carta
  
  def initialize(attributes = {})
    @jogador = attributes[:jogador]
    @carta = attributes[:carta]
  end
end
