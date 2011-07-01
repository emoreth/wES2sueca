class Rodada

  attr_reader :jogadas
  attr_reader :primeiro_jogador
  attr_accessor :naipe

  def initialize
    @jogadas = []
  end

  def nova_jogada(jogada)
    raise "rodada deve ter no máximo 4 jogadas" if @jogadas.length == 4
    if @jogadas.empty?
      @naipe = jogada.carta.naipe
      @primeiro_jogador = jogada.jogador
    end
    @jogadas << jogada
  end

  def vencedor
    maior = 0
    jogador = nil
    @jogadas.each do |jogada|
      if jogada.carta.valor >= maior
        maior = jogada.carta.valor
        jogador = jogada.jogador
      end
    end

    jogador
  end

  def completa?
    @jogadas.length == 4
  end
end
