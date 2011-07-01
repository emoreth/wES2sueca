require 'spec_helper'

describe Jogador do

  before :each do
    @jogadores = [Jogador.new, JogadorIA.new, JogadorIA.new, JogadorIA.new]
    dupla1 = Dupla.new(@jogadores[0], @jogadores[2])
    dupla2 = Dupla.new(@jogadores[1], @jogadores[3])
    @jogo = Jogo.new dupla1, dupla2
    @jogadores[1].jogo = @jogo
    @jogadores[2].jogo = @jogo
    @jogadores[3].jogo = @jogo
    @jogo.nova_partida
    @carta = Carta.new(:naipe => "ouros", :numero => "A")
    @jogador = Jogador.new
  end

  describe "Validações:" do

    it "deve poder receber 10 cartas" do
      lambda{
        cartas = []
        10.times { cartas << @carta.dup }
        @jogador.receber_cartas(cartas)
      }.should_not raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
    end

    it "não deve poder receber cartas e ficar com mais de 10" do
      cartas = []
      10.times { cartas << @carta.dup }
      @jogador.receber_cartas(cartas)
      lambda{ @jogador.receber_cartas([@carta.dup]) }.should raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
    end

    it "não deve poder retirar cartas se não tiver nenhuma" do
      lambda{ @jogador.jogar_carta Carta.new }.should raise_error(ArgumentError, "não há cartas para jogar")
    end
  end

  describe "Atributos:" do

    it "deve ter um id" do
      @jogador.should respond_to :id
      @jogador.id = 1
      @jogador.id.should == 1
    end

    it "deve ter cartas" do
      @jogador.should respond_to :cartas
      @jogador.cartas.should be_empty
    end
  end

  describe "Comportamento:" do

    it "deve poder receber cartas" do
      @jogador.should respond_to :receber_cartas
      @jogador.receber_cartas [@carta.dup, @carta.dup]
      @jogador.cartas.should have(2).cartas
      @jogador.cartas.each { |carta| carta.should be_a Carta }
    end

    it "deve poder jogar carta" do
      @jogador.should respond_to :jogar_carta
      @jogador.receber_cartas [@carta]
      carta_jogada = @jogador.jogar_carta @carta
      carta_jogada.should == @carta
    end

    it "ao receber uma carta, deve marcá-la como sendo sua" do
      @carta.should respond_to :jogador
      @jogador.receber_cartas [@carta]
      @carta.jogador.should be @jogador
    end

    it "deve saber que não é IA" do
      @jogador.should respond_to :ia?
      @jogador.ia?.should be_false
    end

    it "deve saber retornar as cartas de um naipe específico" do
      @jogador.should respond_to :cartas_do_naipe
      carta = Carta.new(:naipe => "ouros", :numero => "A")
      @jogador.receber_cartas([carta])
      @jogador.cartas_do_naipe("ouros").should include carta
    end
  end
end
