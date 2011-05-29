class Partida

  attr_reader :rodadas
  attr_reader :rodada_atual

  def initialize
    @rodadas = []
    nova_rodada
  end

  def nova_rodada
    raise "partida deve ter no máximo 10 rodadas"  if @rodadas.length == 10
    rodada = Rodada.new
    @rodadas << rodada
    @rodada_atual = rodada
  end

  def completa?
    @rodadas.length == 10
  end

  def dupla_vencedora
    @rodadas.each do |rodada|
      rodada.jogadas.each do |jogada|
        jogada.jogador.dupla.pontos_da_partida += jogada.carta.valor
      end
    end
    
    maior = 0
    dupla = nil
    @rodada_atual.jogadas.each do |jogada|
      d = jogada.jogador.dupla
      if d.pontos_da_partida > maior
        maior = d.pontos_da_partida
        dupla = d
      end
    end

    dupla
  end
  
end
