require 'spec_helper'

describe Jogo do

  before :each do
    @jogadores = [Jogador.new, Jogador.new, Jogador.new, Jogador.new]
    dupla1 = Dupla.new(@jogadores[0], @jogadores[2])
    dupla2 = Dupla.new(@jogadores[1], @jogadores[3])
    @jogo = Jogo.new dupla1, dupla2
  end

  describe "Constantes:" do
    it "deve ter dificuldade fácil" do
      Jogo.constants.should include "FACIL"
      Jogo::FACIL.should == "Fácil"
    end

    it "deve ter dificuldade normal" do
      Jogo.constants.should include "NORMAL"
      Jogo::NORMAL.should == "Normal"
    end

    it "deve ter dificuldade difícil" do
      Jogo.constants.should include "DIFICIL"
      Jogo::DIFICIL.should == "Difícil"
    end

    it "deve ter dificuldade expert" do
      Jogo.constants.should include "EXPERT"
      Jogo::EXPERT.should == "Expert"
    end

    it "deve ter lista de dificuldades" do
      Jogo.constants.should include "DIFICULDADES"
      Jogo::DIFICULDADES.should include Jogo::FACIL
      Jogo::DIFICULDADES.should include Jogo::NORMAL
      Jogo::DIFICULDADES.should include Jogo::DIFICIL
      Jogo::DIFICULDADES.should include Jogo::EXPERT
    end

  end

  describe "Validações:" do

    it "deve ser criado com duas duplas" do
      lambda{ Jogo.new }.should raise_error(ArgumentError, "wrong number of arguments (0 for 2)")
      dupla = Dupla.new(Jogador.new, Jogador.new)
      lambda{ Jogo.new dupla, dupla }.should_not raise_error(ArgumentError, "wrong number of arguments (0 for 2)")
    end

    it "deve ter dificuldade válida" do
      lambda{ @jogo.dificuldade = Jogo::FACIL }.should_not raise_error(ArgumentError, "dificuldade deve ser válida")
      lambda{ @jogo.dificuldade = "dificuldade inválida" }.should raise_error(ArgumentError, "dificuldade deve ser válida")
    end
  end

  describe "Atributos:" do

    it "deve ter duas duplas" do
      @jogo.should respond_to :duplas
      @jogo.duplas.should have(2).duplas
    end

    it "deve ter partidas" do
      @jogo.should respond_to :partidas
    end

    it "deve ter partida atual"  do
      @jogo.should respond_to :partida_atual
    end

    it "deve ter nível de dificuldade" do
      @jogo.should respond_to :dificuldade
    end
  end

  describe "Comportamento:" do

    it "deve poder distribuir as cartas" do
      @jogo.should respond_to :nova_partida
      @jogo.nova_partida
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

    it "deve ver jogador atual" do
      @jogo.should respond_to :jogador_atual
      @jogo.escolher_primeiro
      @jogo.jogador_atual.should be_a Jogador
    end
    
    it "deve determinar primeiro jogador" do
      @jogo.should respond_to :escolher_primeiro
      @jogo.jogador_atual.should be_nil
      primeiro = @jogo.escolher_primeiro
      primeiro.should be_a Jogador
      @jogo.jogador_atual.should be primeiro
    end

    it "deve determinar a ordem de jogada" do
      @jogo.should respond_to :proximo_jogador
      primeiro = @jogo.escolher_primeiro
      pos = @jogadores.index primeiro
      4.times { |i| @jogadores[(pos + i + 1) % 4].should be @jogo.proximo_jogador }
    end

    it "deve poder receber nova jogada" do
      @jogo.should respond_to :nova_jogada
      @jogo.nova_partida
      jogada = Jogada.new :jogador => @jogadores.first, :carta => @jogadores.first.cartas.first
      @jogo.nova_jogada jogada
      @jogo.partida_atual.rodada_atual.jogadas.should include jogada
    end
    
    it "deve saber criar nova partida" do
      @jogo.should respond_to :nova_partida
      partida = @jogo.nova_partida
      @jogo.partidas.should include partida
    end

    it "nova partida deve ser a partida atual" do
      partida = @jogo.nova_partida
      @jogo.partida_atual.should be partida
    end

    #    it "deve criar uma referência global para si mesmo" do
    #      Jogo.should respond_to :instance
    #      Jogo.instance.should be @jogo
    #    end

    it "deve distribuir novas cartas ao criar nova partida" do
      @jogo.jogador_atual.should be_nil
      @jogo.nova_partida
      @jogo.jogador_atual.should_not be_nil
    end

    it "deve criar nova rodada ao criar nova partida" do
      @jogo.nova_partida
      @jogo.partida_atual.rodada_atual.should_not be_nil
    end

    describe "jogar uma carta" do

      context "quando não há cartas na mesa" do
        it "deve permitir qualquer carta" do
          @jogo.nova_partida

          jogador = @jogo.jogador_atual
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => jogador.cartas.first).
            should be_true
        end
      end

      context "quando tem carta válida" do
        it "deve permitir carta do mesmo naipe" do
          @jogo.nova_partida

          jogador = @jogo.jogador_atual
          carta = jogador.cartas.first
          carta.naipe = "ouros"
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => carta)

          jogador = @jogo.jogador_atual
          carta = jogador.cartas.first
          carta.naipe = "ouros"
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => carta).
            should be_true
        end

        it "deve impedir carta de outro naipe" do
          @jogo.nova_partida

          jogador = @jogo.jogador_atual
          carta = jogador.cartas.first
          carta.naipe = "ouros"
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => carta)

          jogador = @jogo.jogador_atual
          carta = jogador.cartas.first
          carta.naipe = "paus"
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => carta).
            should be_false
        end
      end

      context "quando não tem carta válida" do
        it "deve permitir qualquer carta" do
          @jogo.nova_partida

          jogador = @jogo.jogador_atual
          carta = jogador.cartas.first
          carta.naipe == "ouros"
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => carta)

          jogador = @jogo.jogador_atual
          jogador.instance_variable_set :@cartas, []
          carta = Carta.new(:naipe => "paus", :numero => "K")
          jogador.receber_cartas [carta]
          @jogo.nova_jogada(Jogada.new :jogador => jogador, :carta => carta).
            should be_true
        end
      end
    end

    it "deve passar a vez do jogador quando for feita uma nova jogada" do
      @jogo.nova_partida
      jogador = @jogo.jogador_atual
      @jogo.nova_jogada(Jogada.new(:jogador => jogador, :carta => jogador.cartas.first))
      @jogo.jogador_atual.should_not be jogador
    end

    it "deve retirar a carta da mão do jogador em uma jogada bem sucedida" do
      @jogo.nova_partida
      jogador = @jogo.jogador_atual
      carta = jogador.cartas.first
      @jogo.nova_jogada(Jogada.new(:jogador => jogador, :carta => carta))
      jogador.cartas.should_not include carta
    end

    it "deve determinar vencedor da rodada como próximo jogador" do
      @jogo.nova_partida
      rodada = @jogo.partida_atual.rodada_atual
      4.times do
        jogador = @jogo.jogador_atual
        carta = jogador.cartas.first
        carta.naipe = "ouros"
#        debugger
        @jogo.nova_jogada(Jogada.new(:jogador => jogador, :carta => carta))
      end
      
      rodada.vencedor.should be @jogo.jogador_atual
    end
  end
end
