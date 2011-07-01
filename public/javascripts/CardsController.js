var CardsController = Class.create({

    initialize : function()
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
            position : 'relative'
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

    throwCard : function(el) {

        if(this.currentPlayer === null) {
            this._findPlayerByCard(el)
        }

        new Effect.Move(el, {
            x: 0,
            y: -100,
            position : 'absolute',
            afterFinish : function(evt){
                var _card = evt.element;
                var _tablePos = this.table.cumulativeOffset();
                var _cardPos = _card.cumulativeOffset();

                this.table.insert(
                    _card.setStyle({
                        top : (_cardPos.top - _tablePos.top - this.borderWidth) + "px",
                        left : (_cardPos.left - _tablePos.left - this.borderWidth) + "px",
                        position : "relative"
                    })
                    );
                _card.absolutize();
                this.setCurrentCard(el);
                this.nextMove();
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

        this._nextPlayer();
        this.announcePlayer();
        new Ajax.Request("proxima_jogada", {
            parameters : params,
            onSuccess : this._moveHandler.bind(this)
        })
    },

    _moveHandler : function(r) {
        var _nextCard = $$("img[data-card_number='"+r.responseJSON.computador.numero_carta+"']").first();
        this.throwCard(_nextCard);
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
            window.NC.growl("É a vez do jogador humano");
        }
        else {
            if(this.currentPlayer !== null) {
                window.NC.growl("E a vez do jogador: " + this.currentPlayer)
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
        window.NC.growl("O jogo começou")
        this.announcePlayer();
        this.nextMove();
    },


    _findPlayerByCard : function(card){
        var _deck = card.up('.deck');
        var _deckOrder = ['baixo', 'esquerda', 'topo', 'direita'];
        this.setFirstPlayer(_deckOrder.indexOf(_deck.readAttribute('data-posicao')))
    }


});