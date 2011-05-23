class Carta

  NAIPES = ["ouros", "espadas", "paus", "copas"]
  NUMEROS = ["A", "7", "K", "J", "Q", "6", "5", "4", "3", "2"]
  
  attr_reader :naipe, :numero

  def initialize(attributes = {})
    @naipe = attributes[:naipe]
    @numero = attributes[:numero]
  end

  def ==(other)
    @naipe == other.naipe &&
      @numero == other.numero
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
    when '2'..'6' then 1
    else raise "Número inválido: #{@numero}"
    end
  end
end
