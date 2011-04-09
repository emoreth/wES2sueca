require 'spec_helper'

describe Dupla do

  describe "Validações:" do
    
    it "deve ser criado com dois jogadores" do
      lambda{ Dupla.new }.should raise_error(ArgumentError, "wrong number of arguments (0 for 2)")
      lambda{ Dupla.new Jogador.new, Jogador.new }.should_not raise_error(ArgumentError, "wrong number of arguments (0 for 2)")
    end
  end

  describe "Atributos:" do

    before :all do
      @dupla = Dupla.new Jogador.new, Jogador.new
    end

    it "deve ter dois jogadores" do
      @dupla.should respond_to :jogadores
      @dupla.jogadores.should have(2).jogadores
    end

    it "deve ter pontos da partida" do
      @dupla.should respond_to :pontos_da_partida
      @dupla.pontos_da_partida.should be_zero
    end

    it "deve ter pontos do jogo" do
      @dupla.should respond_to :pontos_do_jogo
      @dupla.pontos_do_jogo.should be_zero
    end

  end
end
