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
        this._deliverTop()
        
    },

    _deliverTop : function()
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
        }, this._calculateYForVertical)
    },

    _deliverCards : function(selector, container, xPosFunction, yPosFunction) {
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
                    var obj = evt.element;
                    obj.setStyle({
                        left: '',
                        top: '',
                        position: 'relative'
                    })
                    $(container).insert(obj);
                    new Effect.Appear(obj);
                }
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
        new Effect.Move(el, {
                x: 0,
                y: -100,
                position : 'absolute'
            });        
        $('table').insert(el);
        el.removeAttribute('data-selected');
        el.setStyle({
            top : '250px',
            left: '250px'
        })
    }
})