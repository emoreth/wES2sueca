Event.observe(document, 'dom:loaded', function(){
    CC = new CardsController();
    CC.randomizeCards();
    (function(){
        CC.deliverCards();
//        CC.startPlay();
    }).delay(1)
})
