class Dupla

  attr_reader :jogadores, :pontos_da_partida, :pontos_do_jogo

  def initialize(jogador1, jogador2)
    @jogadores = [jogador1, jogador2]
    @pontos_da_partida = 0
    @pontos_do_jogo = 0
  end
end
