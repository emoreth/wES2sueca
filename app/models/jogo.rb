class Jogo

  attr_reader :duplas
  attr_reader :jogador_atual
  attr_reader :trunfo
  attr_reader :partidas
  attr_reader :partida_atual
  attr_reader :dificuldade

  # DIFICULDADES
  FACIL   = "Fácil"
  NORMAL  = "Normal"
  DIFICIL = "Difícil"
  EXPERT  = "Expert"
  DIFICULDADES = [FACIL, NORMAL, DIFICIL, EXPERT]

  def initialize(dupla1, dupla2)
    @duplas = [dupla1, dupla2]
    @jogadores = [dupla1.jogadores[0], dupla2.jogadores[0], dupla1.jogadores[1], dupla2.jogadores[1]]
    @partidas = []
    nova_partida
  end

  def distribuir_cartas
    escolher_primeiro
    baralho = Baralho.new
		@jogadores.each do |jogador|
      jogador.receber_cartas baralho.comprar
    end
    @trunfo = @jogador_atual.cartas.first
  end

  def sortear_jogador
    duplas.sample.jogadores.sample
  end

  def escolher_primeiro
    @jogador_atual = sortear_jogador
  end

  def proximo_jogador
    @jogador_atual = @jogadores[(@jogadores.index(@jogador_atual) + 1) % @jogadores.length]
  end

  def nova_partida
    raise "jogo deve ter no máximo 7 partidas" if @partidas.length == 7
    partida = Partida.new
    @partidas << partida
    @partida_atual = partida
  end

  def nova_jogada(jogada)
    rodada = @partida_atual.rodada_atual
    if rodada.completa?
      if @partida_atual.completa?
        nova_partida
      end
      rodada = @partida_atual.nova_rodada
    end
    rodada.nova_jogada(jogada)
  end

  def dificuldade=(nivel)
    raise ArgumentError, "dificuldade deve ser válida" unless DIFICULDADES.include? nivel
    self[:dificuldade] = nivel
  end
end
