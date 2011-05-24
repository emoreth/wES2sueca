require 'spec_helper'

describe Jogo do

  before :each do
    @jogadores = [Jogador.new, Jogador.new, Jogador.new, Jogador.new]
    dupla1 = Dupla.new(@jogadores[0], @jogadores[2])
    dupla2 = Dupla.new(@jogadores[1], @jogadores[3])
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
    end

    it "deve ver primeiro jogador" do
      @jogo.should respond_to :primeiro_jogador
      @jogo.escolher_primeiro
      @jogo.primeiro_jogador.should be_a Jogador
    end

    it "deve ver jogador atual" do
      @jogo.should respond_to :jogador_atual
      @jogo.escolher_primeiro
      @jogo.jogador_atual.should be_a Jogador
    end
    
    it "deve determinar primeiro jogador" do
      @jogo.should respond_to :escolher_primeiro
      @jogo.primeiro_jogador.should be_nil
      primeiro = @jogo.escolher_primeiro
      primeiro.should be_a Jogador
      @jogo.primeiro_jogador.should be primeiro
    end

    it "deve determinar a ordem de jogada" do
      @jogo.should respond_to :proximo_jogador
      primeiro = @jogo.escolher_primeiro
      pos = @jogadores.index primeiro
      4.times { |i| @jogadores[(pos + i + 1) % 4].should be @jogo.proximo_jogador }
    end
  end
end
