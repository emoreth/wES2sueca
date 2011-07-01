class Jogo

  attr_reader :duplas
  attr_reader :jogador_atual
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
    @dificuldade = FACIL
    @duplas = [dupla1, dupla2]
    @jogadores = [dupla1.jogadores[0], dupla2.jogadores[0], dupla1.jogadores[1], dupla2.jogadores[1]]
    @jogadores.each_with_index { |jogador,i| jogador.id = i }
    @partidas = []
  end

  def distribuir_cartas
    escolher_primeiro
    baralho = Baralho.new
		@jogadores.each do |jogador|
      jogador.receber_cartas baralho.comprar
    end
  end

  def sortear_jogador
    duplas.sample.jogadores.sample
  end

  def escolher_primeiro
    if @jogador_atual
      @jogador_atual = @partida_atual.dupla_vencedora.jogadores.first
    else
      @jogador_atual = sortear_jogador
    end
  end

  def proximo_jogador
    @jogador_atual = @jogadores[(@jogadores.index(@jogador_atual) + 1) % @jogadores.length]
  end

  def nova_partida
    raise "jogo deve ter no máximo 7 partidas" if @partidas.length == 7
    distribuir_cartas
    partida = Partida.new
    @partidas << partida
    @partida_atual = partida
    @partida_atual.trunfo = @jogador_atual.cartas.first
    @partida_atual
  end
#
#  def jogar(carta)
#    nova_jogada(Jogada.new(:jogador => self.jogador_atual, :carta => carta))
#  end

  def nova_jogada(jogada)
    rodada = @partida_atual.rodada_atual
    if rodada_nova? || jogada.jogador.cartas_do_naipe(rodada.naipe).empty? || jogada.carta.naipe == rodada.naipe
      rodada.nova_jogada(jogada)
      jogada.carta.jogar!

      if rodada.completa?
        if @partida_atual.completa?
          nova_partida
        end
        @jogador_atual = rodada.vencedor
        @partida_atual.nova_rodada
      else
        proximo_jogador
      end
      true
    else
      false
    end
  end

  def dificuldade=(nivel)
    raise ArgumentError, "dificuldade deve ser válida" unless DIFICULDADES.include? nivel
    @dificuldade = nivel
  end

  def completo?
    @duplas.detect { |dupla| dupla.pontos_do_jogo >= 4 }
  end

  def rodada_nova?
    @partida_atual.rodada_atual.jogadas.empty?
  end

  def partida_nova?
    @partida_atual.rodadas.length == 1 &&
      rodada_nova?
  end
end
