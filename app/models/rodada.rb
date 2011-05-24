class Rodada

  attr_reader :jogadas

  def initialize
    @jogadas = []
  end

  def nova_jogada(jogada)
    raise "rodada deve ter no máximo 4 jogadas" if @jogadas.length == 4
    @jogadas << jogada
  end

  def vencedor
    maior = 0
    jogador = nil
    @jogadas.each do |jogada|
      if jogada.carta.valor > maior
        maior = jogada.carta.valor
        jogador = jogada.jogador
      end
    end

    jogador
  end
end
