var CardsController = Class.create({

    initialize : function(level)
    {
        this.leftDeck = $("leftDeck");
        if(!this.leftDeck)
            throw Error('O deck da lateral esquerda não foi encontrado. (#leftDeck)');
        this.rightDeck = $("rightDeck");
        if(!this.rightDeck)
            throw Error('O deck da lateral direita não foi encontrado. (#rightDeck)');
        this.topDeck = $("topDeck");
        if(!this.topDeck)
            throw Error('O deck do topo não foi encontrado. (#topDeck)');
        this.bottomDeck = $("bottomDeck");
        if(!this.bottomDeck)
            throw Error('O deck de baixo não foi encontrado. (#bottomDeck)');
        this.table = $("table");
        if(!this.table)
            throw Error('O a mesa não foi encontrada. (#table)');

        this.humanPlayerNumber = 0;
        this.currentPlayer = null;
        this.borderWidth = 20;
        this.cardsDelivered = false;
        this.startPlayAllowed = false;
        this.level = level;
    },

    randomizeCards : function()
    {
        this.table.select('.card').each(function(obj){
            obj.setStyle({
                left : parseInt(Math.random()*500, 10) + "px",
                top : parseInt(Math.random()*300, 10) + "px"
            }).show();
        })
    },

    deliverCards : function()
    {
        this._deliverCards('.top', 'topDeck', this._calculateXForHorizontal, function(){
            return -100
        })
        this._deliverCards('.right', 'rightDeck', function(){
            return 604
        }, this._calculateYForVertical)
        this._deliverCards('.bottom', 'bottomDeck', this._calculateXForHorizontal, function(){
            return 400
        })
        this._deliverCards('.left', 'leftDeck', function(){
            return -100
        }, this._calculateYForVertical, true)
    },

    _deliverCards : function(selector, container, xPosFunction, yPosFunction, lastCards) {
        this.table.select(selector).each(function(obj, index) {

            new Effect.Move(obj, {
                x: xPosFunction(index),
                y: yPosFunction(index),
                mode: 'absolute',
                queue: {
                    scope: ('top_'+index)
                }
            });
            new Effect.Fade(obj, {
                queue: {
                    position: 'end',
                    scope: ('top_'+index)
                },
                afterFinish : function(evt){
                    if(lastCards && !this.cardsDelivered) {
                        this.cardsDelivered = true;
                        if(this.startPlayAllowed) {
                            this._startPlay();
                        }
                    }
                    var obj = evt.element;
                    obj.setStyle({
                        left: '',
                        top: '',
                        position: 'relative'
                    })
                    $(container).insert(obj);
                    new Effect.Appear(obj);
                }.bind(this)
            });
        }.bind(this))
    },

    _calculateXForHorizontal : function(index) {
        return 60*index;
    },

    _calculateYForVertical : function(index) {
        return 30*index;
    },

    selected : function(el)
    {
        return el.getAttribute('data-selected') ? true : false;
    },

    select : function(el)
    {
        new Effect.Move(el, {
            x: 0,
            y: -30,
            position : 'absolute'
        })
        el.setAttribute('data-selected', 'true');
    },

    deselect : function(el) {
        if(this.selected(el))
        {
            new Effect.Move(el, {
                x: 0,
                y: 30,
                position : 'relative'
            })
            el.removeAttribute('data-selected');
        }
    },

    throwCard : function(el, imagem) {

        if(this.currentPlayer === null) {
            this._findPlayerByCard(el)
        }

        var _YPos = [230, 140, 50, 140];
        var _XPos = [230, 90, 230, 370];
        new Effect.Fade(el, {
            afterFinish : function(evt){
                var _card = evt.element;
                this.table.insert(
                    _card.setStyle({
                        top : _YPos[this.currentPlayer] + "px",
                        left : _XPos[this.currentPlayer] + "px",
                        position : "absolute"
                    })
                    );
                if(imagem){
                    _card.writeAttribute('src', '/images/cards/'+imagem+'.png')
                }

                new Effect.Appear(_card, {
                    afterFinish : function(){
                        var _cards = this.table.select('.card');
                        if(_cards.length == 4) {
                            _cards.each(function(card){
                                new Effect.Fade(card, {
                                    afterFinish : function(evt){
                                        if(this.table.select('.card').length == 4) {
                                            $(evt.element).remove();
                                            this.setCurrentCard(el);
                                            this.nextMove();

                                        }
                                    }.bind(this)
                                });
                            }.bind(this))
                        } else {
                            this.setCurrentCard(el);
                            this.nextMove();
                        }
                        
                    }.bind(this)
                })
            }.bind(this)
        });

        el.removeAttribute('data-selected');

    },

    setCurrentCard : function(value) {
        this.currentCard = $(value);
    },

    nextMove: function(){
        params = {};
        if(this.isHumanPlayer()) {
            params.numero_carta = (this.currentCard ? this.currentCard.getAttribute('data-card_number') : null)
        }
        if(this.currentPlayer === null) {
            params.game_level = this.level;
        }

        this._nextPlayer();
        this.announcePlayer();
        new Ajax.Request("proxima_jogada", {
            parameters : params,
            onSuccess : this._moveHandler.bind(this)
        })
    },

    _moveHandler : function(r) {
        var _nextCard = $$("img[data-card_number='"+r.responseJSON.computador.numero_carta+"']").first();
        var _imagemCarta = false;
        if(r.responseJSON.computador) {
            _imagemCarta = r.responseJSON.computador.imagem_carta
        }
        if(r.responseJSON.trunfo) {
            $('trunfo').writeAttribute('src', '/images/cards/'+r.responseJSON.trunfo+'.png')
        }
        this.throwCard(_nextCard, _imagemCarta);
    },

    setFirstPlayer: function(playerNumber)
    {
        if(!Object.isNumber(playerNumber) || playerNumber == NaN) {
            throw Error('O jogador atual deve ser representado por um número');
        }

        this.currentPlayer = playerNumber;
    },

    _nextPlayer : function() {
        if(this.currentPlayer !== null) {
            this.currentPlayer++;
            if(this.currentPlayer >= 4) {
                this.currentPlayer = 0;
            }
        }
        
    },

    isHumanPlayer : function() {
        return this.currentPlayer == this.humanPlayerNumber;
    },

    announcePlayer : function() {
        if(this.isHumanPlayer()) {
            window.NC.growl("É a vez do jogador humano", {
                sticky: true
            });
        }
        else {
            if(this.currentPlayer !== null) {
                window.NC.growl("E a vez do jogador: " + this.currentPlayer, {
                    sticky: true
                })
            }
        }

    },

    startPlay : function() {
        if(this.startPlayAllowed) {
            this._startPlay();
        } else {
            this.startPlayAllowed = true;
        }
    },

    _startPlay : function() {
        window.NC.growl("O jogo começou", {
            sticky: true
        })
        $('trunfo').show();
        this.announcePlayer();
        this.nextMove();
    },


    _findPlayerByCard : function(card){
        var _deck = card.up('.deck');
        var _deckOrder = ['baixo', 'esquerda', 'topo', 'direita'];
        this.setFirstPlayer(_deckOrder.indexOf(_deck.readAttribute('data-posicao')))
    }


});