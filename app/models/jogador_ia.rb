class JogadorIA < Jogador

  def ia?
    true
  end

  def proxima_jogada(naipe)
    self.cartas_validas(naipe).first
  end

  def cartas_validas(naipe)
    @cartas.select do |carta|
      if naipe
        carta.naipe == naipe
      else
        true
      end
    end
  end
  
end