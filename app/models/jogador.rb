class Jogador

  attr_reader :cartas
  attr_accessor :dupla
  attr_accessor :id

  def initialize
    @cartas = []
  end

  def receber_cartas(cartas)
    raise ArgumentError, "jogador deve ter no máximo 10 cartas" if (@cartas.length + cartas.length) > 10
    @cartas += cartas
    cartas.each { |carta| carta.jogador = self }
    @cartas.sort!
  end

  def jogar_carta(carta)
    raise ArgumentError, "não há cartas para jogar" if @cartas.empty?
    @cartas.delete_at @cartas.index(carta) if @cartas.index(carta)
  end

  def ia?
    false
  end

  def cartas_do_naipe(naipe)
    @cartas.select { |carta| carta.naipe == naipe }
  end
end
