require 'spec_helper'

describe Baralho do

  before :all do
    @baralho = Baralho.new
  end

  describe "Comportamento:" do
    it "deve saber criar um baralho com as cartas certas" do

      @baralho.cartas.should have(40).cartas
      Carta::NAIPES.each do |naipe|
        Carta::NUMEROS.each do |numero|
          @baralho.cartas.should include Carta.new( :naipe => naipe, :numero => numero )
        end
      end
    end

    it "deve saber embaralhar suas cartas" do

      @baralho.should respond_to :embaralhar
      copia_cartas = @baralho.cartas.dup
      @baralho.embaralhar
      @baralho.cartas.should_not == copia_cartas
    end

    it "deve saber comprar carta" do

      @baralho.should have(40).cartas
      @baralho.should respond_to :comprar
      cartas = @baralho.comprar
      @baralho.should have(30).cartas
      cartas.should have(10).cartas
    end
  end
end