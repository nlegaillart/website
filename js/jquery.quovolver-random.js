$(document).ready(function() {
    var $items = $('.quovolver .quote');
    var quovolver = $('.quovolver');
    var newItems = [];

    $.each($items, function(i, quote) {
        var $copy = $(quote);
        newItems.push($copy);
        $copy.remove();
    });

    var random;
    var chosenRandom = [];
    for (var i = 0; i < newItems.length - 1; i++) {
        random = Math.floor(Math.random() * newItems.length);
        while ($.inArray(random, chosenRandom) != -1) {
            random = Math.floor(Math.random() * newItems.length);
        }
        chosenRandom.push(random);
        quovolver.append(newItems[random]);
    }
    $('div.quovolver').quovolver({autoPlaySpeed : 6000});
});
