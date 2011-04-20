Event.observe(document, 'dom:loaded', function(){
    CC = new CardsController();
    CC.randomizeCards();
    (function(){
        CC.deliverCards();
    }).delay(1)
})
