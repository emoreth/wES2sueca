class JogadorIA < Jogador

  def ia?
    true
  end

  def proxima_jogada(naipe)
    cartas_validas = self.cartas_validas(naipe)
    if cartas_validas.empty?
      cartas_validas = @cartas
    end
    cartas_validas.first
  end

  def cartas_validas(naipe)
    @cartas.select { |carta| carta.naipe == naipe }
  end
end
  