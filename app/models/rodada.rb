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
    maior = @jogadas.first.carta
    jogador = @jogadas.first.jogador
    @jogadas.each do |jogada|
      if jogada.carta.valor >= maior.valor
        maior = jogada.carta
        jogador = jogada.jogador
      end
      if jogada.carta.naipe == @naipe
        if maior.naipe == @naipe
          if jogada.carta.valor > maior.valor
            maior = jogada.carta
          end
        else
          maior = jogada.carta
        end
      end
    end

    jogador
  end

  def completa?
    puts "*" * 20
    puts "o numero de rodadas atual é #{@jogadas.length}"
    puts "*" * 20
    @jogadas.length == 4
  end
end
