# language: pt
@javascript
Funcionalidade: Jogo
  Para jogar sueca
  Como um jogador
  Eu quero jogar cartas
  E os outros jogadores responderem

  Contexto:
    Dado que eu estou na página de jogo

  Cenário: Devo ver minhas cartas
    Então eu devo ver as cartas de baixo viradas para cima

  Cenário: Não devo ver as cartas dos outros jogadores
    Então eu devo ver as cartas da esquerda viradas para baixo
    E eu devo ver as cartas de cima viradas para baixo
    E eu devo ver as cartas da direita viradas para baixo