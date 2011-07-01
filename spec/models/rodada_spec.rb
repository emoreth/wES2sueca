require 'spec_helper'

describe Rodada do

  before :each do
    @rodada = Rodada.new
  end
  
  describe "Atributos:" do
    it "deve ter jogadas" do
      @rodada.should respond_to :jogadas
      @rodada.jogadas.should be_empty
    end

    it "deve saber naipe da rodada" do
      jogadores = [Jogador.new, Jogador.new, Jogador.new, Jogador.new]
      dupla1 = Dupla.new(jogadores[0], jogadores[2])
      dupla2 = Dupla.new(jogadores[1], jogadores[3])
      jogo = Jogo.new dupla1, dupla2
      jogo.nova_partida
      rodada = jogo.partida_atual.rodada_atual
      carta = jogo.jogador_atual.cartas.first.jogar!
      jogo.nova_jogada(Jogada.new(:jogador => jogo.jogador_atual, :carta => carta))
      rodada.should respond_to :naipe
      rodada.naipe.should == carta.naipe
    end

  end

  describe "Comportamento:" do
    it "deve receber nova jogada" do
      @rodada.should respond_to :nova_jogada
      jogada = Jogada.new :carta => Carta.new
      @rodada.nova_jogada jogada
      @rodada.jogadas.should include jogada
    end

    it "deve receber no máximo quatro jogadas" do
      lambda{
        4.times { @rodada.nova_jogada Jogada.new(:carta => Carta.new) }
      }.should_not raise_error(RuntimeError, "rodada deve ter no máximo 4 jogadas")

      lambda{
        @rodada.nova_jogada Jogada.new(:carta => Carta.new)
      }.should raise_error(RuntimeError, "rodada deve ter no máximo 4 jogadas")
    end

    it "deve saber quem é o vencedor da rodada" do
      @rodada.should respond_to :vencedor

      jogadores = [Jogador.new, Jogador.new, Jogador.new, Jogador.new]
      cartas = [Carta.new(:numero => "A"), Carta.new(:numero => "7"), Carta.new(:numero => "K"), Carta.new(:numero => "J")]

      rodada = Rodada.new
      4.times do |i|
        rodada.nova_jogada Jogada.new(:jogador => jogadores[i], :carta => cartas[i])
      end
      rodada.vencedor.should be jogadores[0]
      
      cartas.reverse!
      rodada = Rodada.new
      4.times do |i|
        rodada.nova_jogada Jogada.new(:jogador => jogadores[i], :carta => cartas[i])
      end
      rodada.vencedor.should be jogadores[3]
    end

    it "deve saber se está completa" do
      @rodada.should respond_to :completa?
      @rodada.should_not be_completa

      4.times do
        @rodada.nova_jogada(
          Jogada.new(
            :jogador => Jogador.new,
            :carta => Carta.new(:naipe => "ouros", :numero => "A")
          )
        )
      end
      
      @rodada.should be_completa
    end

    it "deve saber quem foi o primeiro jogador" do
      @rodada.should respond_to :primeiro_jogador
      jogador = Jogador.new
      carta = Carta.new(:naipe => "ouros", :numero => "A")
      jogador.receber_cartas([carta])
      @rodada.nova_jogada(Jogada.new(:jogador => jogador, :carta => carta))

      @rodada.primeiro_jogador.should be jogador
    end
  end
end
