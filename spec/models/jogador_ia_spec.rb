require 'spec_helper'

describe JogadorIA do

  before :each do
    @jogadorIA = JogadorIA.new
    @jogadores = [Jogador.new, JogadorIA.new, JogadorIA.new, @jogadorIA]
    dupla1 = Dupla.new(@jogadores[0], @jogadores[2])
    dupla2 = Dupla.new(@jogadores[1], @jogadores[3])
    @jogo = Jogo.new dupla1, dupla2
    @jogo.nova_partida
  end

  describe "Comportamento:" do
    it "deve saber que é IA" do
      @jogadorIA.should respond_to :ia?
      @jogadorIA.ia?.should be_true
    end

    it "deve saber jogar carta" do
      @jogadorIA.should respond_to :proxima_jogada
      @jogadorIA.proxima_jogada.should be_a Carta
    end
  end
end