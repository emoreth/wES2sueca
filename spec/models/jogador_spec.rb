require 'spec_helper'

describe Jogador do

  before :each do
    @jogador = Jogador.new
  end

  describe "Validações:" do

    it "deve poder receber 10 cartas" do
      lambda{
        cartas = []
        10.times { cartas << Carta.new }
        @jogador.receber_cartas(cartas)
      }.should_not raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
    end

    it "não deve poder receber cartas e ficar com mais de 10" do
      cartas = []
      10.times { cartas << Carta.new }
      @jogador.receber_cartas(cartas)
      lambda{ @jogador.receber_cartas([Carta.new]) }.should raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
    end

    it "não deve poder retirar cartas se não tiver nenhuma" do
      lambda{ @jogador.jogar_carta Carta.new }.should raise_error(ArgumentError, "não há cartas para jogar")
    end
  end

  describe "Atributos:" do

    it "deve ter cartas" do
      @jogador.should respond_to :cartas
      @jogador.cartas.should be_empty
    end
  end

  describe "Comportamento:" do

    it "deve poder receber cartas" do
      @jogador.should respond_to :receber_cartas
      @jogador.receber_cartas [Carta.new, Carta.new]
      @jogador.cartas.should have(2).cartas
      @jogador.cartas.each { |carta| carta.should be_a Carta }
    end

    it "deve poder jogar carta" do
      @jogador.should respond_to :jogar_carta
      carta = Carta.new
      @jogador.receber_cartas [carta]
      carta_jogada = @jogador.jogar_carta carta
      carta_jogada.should == carta
    end
  end
end
