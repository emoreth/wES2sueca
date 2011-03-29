require 'spec_helper'

describe Carta do

  describe "constantes da classe" do

    it "deve ter a lista de naipes" do
      Carta.constants.should include "NAIPES"
      Carta::NAIPES.should == ["ouros", "espadas", "paus", "copas"]
    end

    it "deve ter a lista de números" do
      Carta.constants.should include "NUMEROS"
      Carta::NUMEROS.should == ["A", "7", "K", "J", "Q", "6", "5", "4", "3", "2"]
    end
  end

  it "deve ter um naipe" do
    carta = Carta.new
    carta.should respond_to :naipe
    carta.naipe = Carta::NAIPES.first
    carta.naipe.should == Carta::NAIPES.first
  end

  it "deve ter um naipe" do
    carta = Carta.new
    carta.should respond_to :numero
    carta.numero = Carta::NUMEROS.first
    carta.numero.should == Carta::NUMEROS.first
  end

  it "deve aceitar um hash na inicialização" do
    # Não sei bem como testar isso, se alguém tiver uma idéia melhor pode mudar à vontade!
    lambda{
      carta = Carta.new :naipe => "ouros", :numero => "A"
      carta.naipe.should == "ouros"
      carta.numero.should == "A"
      }.should_not raise_error(ArgumentError, "wrong number of arguments")
  end

end
