require 'spec_helper'

describe Partida do

  before :each do
    @partida = Partida.new
  end

  describe "Atributos:" do
    it "deve ter rodadas" do
      @partida.should respond_to :rodadas
    end

    it "deve saber a rodada atual" do
      @partida.should respond_to :rodada_atual
    end

    it "deve saber o trunfo da partida" do
      jogadores = [Jogador.new, Jogador.new, Jogador.new, Jogador.new]
      dupla1 = Dupla.new(jogadores[0], jogadores[2])
      dupla2 = Dupla.new(jogadores[1], jogadores[3])
      jogo = Jogo.new dupla1, dupla2
      jogo.nova_partida

      jogo.partida_atual.should respond_to :trunfo
      trunfo = jogo.partida_atual.trunfo
      trunfo.should be_a Carta
      jogo.jogador_atual.cartas.should include trunfo
    end
  end

  describe "Validações:" do
    it "deve ter no máximo 10 rodadas" do
      lambda{
        9.times { @partida.nova_rodada }
      }.should_not raise_error(RuntimeError, "partida deve ter no máximo 10 rodadas")

      lambda{
        @partida.nova_rodada
      }.should raise_error(RuntimeError, "partida deve ter no máximo 10 rodadas")
    end
  end

  describe "Comportamento:" do
    it "deve criar nova rodada" do
      @partida.should respond_to :nova_rodada
      rodada = @partida.nova_rodada
      @partida.rodadas.should include rodada
    end

    it "deve saber se está completa" do
      @partida.should respond_to :completa?
      @partida.should_not be_completa

      9.times do
        rodada = @partida.nova_rodada
        4.times do
          rodada.nova_jogada(
            Jogada.new(
              :jogador => Jogador.new,
              :carta => Carta.new(:naipe => "ouros", :numero => "A")
            )
          )
        end
      end

      @partida.should be_completa
    end

    it "deve saber o vencedor da partida" do
      jogadores = [Jogador.new, Jogador.new, Jogador.new, Jogador.new]
      duplas = [Dupla.new(jogadores[0], jogadores[2]),
        Dupla.new(jogadores[1], jogadores[3])]
      jogo = Jogo.new duplas[0], duplas[1]
      jogo.nova_partida

      jogo.partida_atual.should respond_to :dupla_vencedora

      10.times do |i|
        jogo.nova_jogada(Jogada.new(:jogador => jogadores[0], :carta => Carta.new(:naipe => "ouros", :numero => "A")))
        jogo.nova_jogada(Jogada.new(:jogador => jogadores[2], :carta => Carta.new(:naipe => "ouros", :numero => "A")))
        jogo.nova_jogada(Jogada.new(:jogador => jogadores[1], :carta => Carta.new(:naipe => "ouros", :numero => "2")))
        jogo.nova_jogada(Jogada.new(:jogador => jogadores[3], :carta => Carta.new(:naipe => "ouros", :numero => "2")))
      end
      
      jogo.partida_atual.dupla_vencedora.should be duplas[0]
    end

    it "nova rodada deve ser a rodada atual" do
      rodada = @partida.nova_rodada
      @partida.rodada_atual.should be rodada
    end

  end

end
