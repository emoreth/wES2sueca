require 'spec_helper'

describe Jogador do

  before :each do
    @jogador = Jogador.new
  end

  describe "Validações:" do

    it "deve aceitar no máximo 10 cartas" do
      lambda{
        10.times do |i|
          @jogador.receber_carta Carta.new
        end
      }.should_not raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
      
      lambda{ @jogador.receber_carta Carta.new }.should raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
    end

    it "deve aceitar no máximo 10 cartas quando recebendo várias" do
      lambda{
        cartas = []
        9.times do |i|
          cartas << Carta.new
        end
        @jogador.receber_cartas cartas
      }.should_not raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")

      lambda{ @jogador.receber_cartas [Carta.new, Carta.new] }.should raise_error(ArgumentError, "jogador deve ter no máximo 10 cartas")
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

    it "deve poder receber carta" do
      @jogador.should respond_to :receber_carta
      carta = Carta.new
      @jogador.receber_carta carta
      @jogador.cartas.should have(1).carta
      @jogador.cartas.first.should be carta
    end

    it "deve poder receber mais de uma carta" do
                        
      @jogador.should respond_to :receber_cartas
            @jogador.receber_cartas [Carta.new, Carta.new]
      @jogador.cartas.should have(2).cartas
    end

    it "deve poder jogar carta" do
      @jogador.should respond_to :jogar_carta
      carta = Carta.new
      @jogador.receber_carta carta
      carta_jogada = @jogador.jogar_carta carta
      carta_jogada.should == carta
    end
  end
end
