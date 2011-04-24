require 'spec_helper'

describe Jogo do

  before :each do
    dupla1 = Dupla.new(Jogador.new, Jogador.new)
    dupla2 = Dupla.new(Jogador.new, Jogador.new)
    @jogo = Jogo.new dupla1, dupla2
  end

  describe "Validações:" do

    it "deve ser criado com duas duplas" do
      lambda{ Jogo.new }.should raise_error(ArgumentError, "wrong number of arguments (0 for 2)")
      dupla = Dupla.new(Jogador.new, Jogador.new)
      lambda{ Jogo.new dupla, dupla }.should_not raise_error(ArgumentError, "wrong number of arguments (0 for 2)")
    end
  end

  describe "Atributos:" do

    it "deve ter duas duplas" do
      @jogo.should respond_to :duplas
      @jogo.duplas.should have(2).duplas
    end
  end

  describe "Comportamento:" do

    it "deve poder distribuir as cartas" do
      @jogo.should respond_to :distribuir_cartas
      @jogo.distribuir_cartas
      @jogo.duplas.each do |dupla|
        dupla.jogadores.each do |jogador|
          jogador.cartas.should have(10).cartas
        end
      end
    end

    it "deve escolher jogador aleatoriamente" do
      @jogo.should respond_to :sortear_jogador
      jogador = @jogo.sortear_jogador
      jogador.should be_a Jogador
      jogador.should_not be @jogo.sortear_jogador
    end
  end
end
