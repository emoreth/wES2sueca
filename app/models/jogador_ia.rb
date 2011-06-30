class JogadorIA < Jogador

  def ia?
    true
  end

  def proxima_jogada(naipe)
    self.cartas_validas(naipe).first
  end

  def cartas_validas(naipe)
    @cartas.select { |carta| carta.naipe == naipe }
  end
  
end