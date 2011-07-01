class IA

  attr_reader :jogo

  def initialize(jogo = nil)
    if jogo.nil?
      @jogador1 = Jogador.new
      @jogador2 = JogadorIA.new
      @jogador3 = JogadorIA.new
      @jogador4 = JogadorIA.new

      @dupla1 = Dupla.new @jogador1, @jogador3
      @dupla2 = Dupla.new @jogador2, @jogador4

      @jogo = Jogo.new @dupla1, @dupla2
      @jogo.nova_partida
    else
      @jogo = jogo
    end
  end

  def jogo
    @jogo
  end

  def inspect
    "IA Class"
  end

  def jogador
    @jogo.jogador_atual
  end

  def cartas
    jogador.cartas
  end

  def partida
    @jogo.partida_atual
  end

  def trunfo
    partida.trunfo
  end

  def naipe_do_trunfo
    trunfo.naipe
  end

  def rodada
    partida.rodada_atual
  end
  def jogadas
    rodada.jogadas
  end

  def maior_carta_da_mesa_com_naipe(naipe)
    jogadas.select { |j| j.carta.naipe == naipe }.collect { |p| p.carta.valor }.max
  end

  def maior_carta_da_mesa
    jogadas.collect { |p| p.carta.valor }.max
  end

  def pontos_da_mesa
    jogadas.collect { |j| j.carta.valor }.sum
  end


  # Nivel de dificuldade Easy
  def turno_nivel_facil
    if tem_naipe_da_rodada_ou_trunfo?
      joga_maior_carta
    else
      joga_menor_carta
    end
  end

  def primeiro_jogador?
    return jogadas.empty?
  end


  def naipe_da_rodada
    rodada.naipe
  end

  # Nivel de dificuldade Normal
  def turno_nivel_normal
    if tem_naipe_da_rodada_ou_trunfo?
      if pontos_da_mesa > 0
        return joga_a_menor_carta_suficiente_para_ganhar_a_rodada
      end
    end
    joga_menor_carta
  end

  # Nivel de dificuldade Hard
  def turno_nivel_dificil
    if tem_naipe_da_rodada_ou_trunfo?
      if pontos_da_mesa > 0
        if tem_carta_maior_do_que_a_maior_carta_da_mesa?
          return joga_maior_carta
        end
      end
    end
    joga_menor_carta
  end

  # Indica se uma carta possui algum ponto
  def carta_tem_ponto?(carta)
    ['A', '7', 'K', 'J', 'Q'].include? carta.numero
  end

  # Indica se o usuario corrente possui alguma carta para ser jogada no contexto do jogo.
  def tem_naipe_da_rodada_ou_trunfo?
    return true if primeiro_jogador?
    cartas.each do |carta|
      naipe = carta.naipe
      if naipe == naipe_da_rodada or naipe == naipe_do_trunfo
        return true
      end
    end
    false
  end

  # Verifica se possui uma carta maior do que a maior carta da mesa
  def tem_carta_maior_do_que_a_maior_carta_da_mesa?
    return true if primeiro_jogador?

    max = maior_carta_da_mesa
    cartas.each do |carta|
      if carta.valor > max
        return true
      end
    end
    false
  end

  # Jogador irá jogar uma carta maior do que a maior carta da mesa
  def joga_a_menor_carta_suficiente_para_ganhar_a_rodada
    # Procura por uma carta maior de mesmo naipe
    cartas do |carta|
      if carta.valor > maior_carta_da_mesa and carta.naipe = rodada.naipe
        return jogo.jogar(carta)
      end
    end
    max = maior_carta_da_mesa_com_naipe(rodada.naipe)
    # Procura por uma carta maior de naipe do trunfo
    cartas.each do |carta|
      if carta.valor > max and carta.naipe = trunfo.naipe
        return jogo.jogar(carta)
      end
    end
    joga_menor_carta
  end

  # Jogador irá jogar a menor carta da sua mão
  def joga_menor_carta
    naipe = rodada.naipe
    2.times do
      cartas.each do |carta|
        if carta.valor == 0 and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.valor == 0 and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == 'Q' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == 'J' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == 'K' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == '7' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == 'A' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      naipe = trunfo.naipe
    end
    jogo.jogar(cartas.sample)
  end

  # Jogador irá jogar a maior carta da sua mão
  def joga_maior_carta
    naipe = rodada.naipe
    2.times do
      cartas.each do |carta|
        if carta.valor == 'A' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.valor == '7' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.valor == 'K' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.valor == 'J' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == 'Q' and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      cartas.each do |carta|
        if carta.numero == 0 and (naipe.nil? or carta.naipe == naipe)
          return jogo.jogar(carta)
        end
      end
      naipe = trunfo.naipe
    end
    return jogo.jogar(cartas.sample);
  end
end