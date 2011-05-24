require 'spec_helper'

describe Jogada do

  before :each do
    @jogada = Jogada.new :jogador => Jogador.new, :carta => Carta.new
  end

  describe "Atributos:" do
    it "deve ter um jogador" do
      @jogada.should respond_to :jogador
      @jogada.jogador.should be_a Jogador
    end

    it "deve ter uma carta" do
      @jogada.should respond_to :carta
      @jogada.carta.should be_a Carta
    end
  end
end
