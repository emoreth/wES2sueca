class Dupla

  attr_reader :jogadores
  attr_accessor :pontos_da_partida, :pontos_do_jogo

  def initialize(jogador1, jogador2)
    @jogadores = [jogador1, jogador2]
    jogador1.dupla = self
    jogador2.dupla = self
    @pontos_da_partida = 0
    @pontos_do_jogo = 0
  end
end
