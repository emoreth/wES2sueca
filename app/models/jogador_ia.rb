class JogadorIA < Jogador

  def ia?
    true
  end

  def proxima_jogada
    self.cartas.first
  end
  
end