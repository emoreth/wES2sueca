class Carta

  NAIPES = ["ouros", "espadas", "paus", "copas"]
  NUMEROS = ["A", "7", "K", "J", "Q", "6", "5", "4", "3", "2"]
  
  attr_reader :naipe, :numero
  attr_accessor :jogador, :id

  def initialize(attributes = {})
    @naipe = attributes[:naipe]
    @numero = attributes[:numero]
  end

  def ==(other)
    if other.class == Carta
      @naipe == other.naipe &&
        @numero == other.numero
    else
      @id == other
    end
  end

  def <=> other
    if @naipe != other.naipe
      @naipe<=>other.naipe
    elsif self.valor != other.valor
      self.valor<=>other.valor
    else
      @numero <=> other.numero
    end
  end

  def nome_arquivo
    arquivo = case @naipe
    when "ouros"
      "d"
    when "espadas"
      "s"
    when "paus"
      "c"
    when "copas"
      "h"
    else
      raise "Estado ilegal da carta: #{self.inspect}"
    end

    arquivo + @numero.downcase
  end

  def valor
    case @numero
    when 'A' then 11
    when '7' then 10
    when 'K' then 4
    when 'J' then 3
    when 'Q' then 2
    when '2'..'6' then 0
    else raise "Número inválido: #{@numero}"
    end
  end

  def jogar!
    @jogador.jogar_carta self
  end
end
