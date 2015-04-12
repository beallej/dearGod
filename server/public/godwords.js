$(document).ready(function() {
    var getWords = function() {
        setInterval(function() {
            $.get( "/api/God", function( data ) {
                $("span#god-words").html(data.words);
            });

        }, 1000 * 7);
    }
    getWords();

});
