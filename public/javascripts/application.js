Event.observe(document, 'dom:loaded', function(){

    Modalbox.show($('want_to_play'), {
        title : "Teste",
        height : 100,
        onShow : function() {
            $('start_game').observe('click', function(){
                Modalbox.hide();
                CC = new CardsController();
                CC.randomizeCards();
                (function(){
                    CC.deliverCards();
                    CC.startPlay();
                }).delay(1)
            })
        }
    });

    window.NC = new Growler({location:"br"});

    
})
