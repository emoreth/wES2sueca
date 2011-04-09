class Dupla

  attr_accessor :jogadores, :pontos_da_partida, :pontos_do_jogo

  def initialize(jogador1, jogador2)
    self.jogadores = [jogador1, jogador2]
    self.pontos_da_partida = 0
    self.pontos_do_jogo = 0
  end
end
