Event.observe(document, 'dom:loaded', function(){
    Modalbox.show($('want_to_play'), {
        title : "Teste",
        height : 100,
        onShow : function() {
            $$('.start_game').each(function(button){
                button.observe('click', function(evt){
                    Modalbox.hide();
                    CC = new CardsController(evt.element().value);
                    CC.randomizeCards();
                    (function(){
                        CC.deliverCards();
                        CC.startPlay();
                    }).delay(1)
                })
            })
    }
});

window.NC = new Growler({location:"br"});
   
});
