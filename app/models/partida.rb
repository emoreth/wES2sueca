class Partida

  attr_reader :rodadas
  attr_reader :rodada_atual
  attr_accessor :trunfo

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

    unless @dupla_vencedora
      dupla1 = @rodada_atual.jogadas[0].jogador.dupla
      dupla2 = @rodada_atual.jogadas[1].jogador.dupla

      dupla1.pontos_da_partida = 0
      dupla2.pontos_da_partida = 0

      @rodadas.each do |rodada|
        rodada.jogadas.each do |jogada|
          jogada.jogador.dupla.pontos_da_partida += jogada.carta.valor
        end
      end
    
      if dupla1.pontos_da_partida > dupla2.pontos_da_partida
        @dupla_vencedora = dupla1
      elsif dupla1.pontos_da_partida > dupla2.pontos_da_partida
        @dupla_vencedora = dupla2
      end

      @dupla_vencedora.pontos_do_jogo = case @dupla_vencedora.pontos_da_partida
      when 61..90
        1
      when 91..119
        2
      when 120
        4
      end
    end

    @dupla_vencedora
  end
  
end
