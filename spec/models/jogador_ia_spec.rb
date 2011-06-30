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

    it "deve saber identificar cartas válidas  na mão" do
      @jogadorIA.should respond_to :cartas_validas
      cartas_validas = [Carta.new(:naipe => "ouros", :numero =>  "A"), Carta.new(:naipe => "ouros", :numero => "2")]
      cartas_invalidas = [Carta.new(:naipe => "paus", :numero => "A"), Carta.new(:naipe => "paus", :numero => "2")]
      @jogadorIA.instance_variable_set :@cartas, cartas_validas + cartas_invalidas
      @jogadorIA.cartas_validas("ouros").should == cartas_validas
    end

    it "deve saber jogar carta válida" do
      @jogadorIA.should respond_to :proxima_jogada
      carta = Carta.new :naipe => "ouros", :numero => "2"
      @jogadorIA.instance_variable_set :@cartas, [Carta.new(:naipe => "paus", :numero => "A"), carta]
      @jogadorIA.proxima_jogada("ouros").should be carta
    end
  end
end