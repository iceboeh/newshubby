$(document).ready(function() {

    var i = 1; // en ränkare som står på 1
    var qCount = $('.question').length; //räkna antalet .question på sidan
    console.log('There are ' + qCount + ' question divs present'); // skriv ut antalet .question i console
    
    var hideModal = function(){
        $('.overlay').hide(); // dölj eventuell dim-bakgrund som syns
        $('[id^=modal]').hide(); // dölj eventuell hint som syns
    };
    
    var skipQuestions = function() {

        $('#q' + i).show(); //visa den fråga räknaren (i) står på (fråga 1)
        activeBtn();

        $('#next').click(function(){ // NEXT-button
            if ( i < qCount ){ // om i är mindre än antalet .questions gör...
                i ++; // addera med 1 på räknaren
                console.log(i); // skriv ut vad räknaren nu står på
                $('[id^=q].question').not('#q' + i).hide(); // dölj alla tidigare #q
                console.log('hiding');
                $('#q' + i).show(); // visa den fråga som räknaren (i) står på
                console.log('showing');
                hideModal();
                // var inputCharLen = $('#input' + i).val().length();
                activeBtn();
                //$('#input' + i).length();
                $('#input' + i).focus(); // ställ markören i textarea
            }
        });

        $('#prev').click(function(){ // PREV-button
            if (i > 1) { // om i är större än antalet .questions gör...
                i --; // subtrahera med 1 på räknaren
                console.log(i); // skriv ut vad räknaren nu står på
                $('[id^=q].question').not('#q' + i).hide(); // dölj alla tidigare #q
                console.log('hiding');
                $('#q' + i).show(); // visa den fråga som räknaren (i) står på
                console.log('showing');
                hideModal();
                activeBtn();
                $('#input' + i).focus(); // ställ markören i textarea
            }
        });

        $('textarea').keydown(function(e) {
            if (e.keyCode == 13){
                e.preventDefault();
                $("#next").click();
            } //enter
        });
    };

    var handleHints = function() {

        $(document).keyup(function(e) {
            if (e.keyCode == 27) {
                $('.overlay').hide();
                $('#modal' + i).hide();
            }   // esc
        });

        /* $(document).on('click', function(e) {
            if !(e.target.id == '.overlay-message' || e.target.id == '.hints') {
                $('.overlay').hide();
                $('#modal' + i).hide();
        }); */

        $('.hints').click(function(){
            /* if ($('.overlay').is(':visible') || $('.#modal' + [0-9]).is(':visible')) {
                console.log( 'overlay or modal is visible');
                $('.overlay').hide();
                $('#modal' + [0-9]).hide();
            } */
            $('.overlay').toggle();
            $('#modal' + i).toggle();
        });

        $('.closeModal').click(function(){
            $('.overlay').hide();
            $('#modal' + i).hide();
        });
    };
    
    var prestoNav = function() {
        var i2 = 1;
        while (i2 <= qCount) {
            if (i2 < qCount) {
                $('#prestoNavUL').append("<li><div class='prestoNavBtn' id='" + i2 + "' data-id='" + i2 + "'>" + i2 + "</div></li><li><div class='space'></div></li>");
            } else {
                $('#prestoNavUL').append("<li><div class='prestoNavBtn' id='" + i2 + "' data-id='" + i2 + "'>" + i2 + "</div></li>");
            }
            i2++;
        }
        
        $('.prestoNavBtn').click(function(){
            $('[id^=q].question').not('#q' + $(this).data('id')).hide(); // dölj alla tidigare #q
            hideModal();
            $('#q'+$(this).data('id')).show();
            i = $(this).data('id');
            activeBtn();
        });
    };
    
    var activeBtn = function() {
        $('.prestoNavBtn').not('#' + i).removeClass('active');
        $('#' + i).addClass('active');
    };
    
    skipQuestions();
    handleHints();
    prestoNav();
    activeBtn();
    
    /* 
    var textareaContent = $("#textarea").get();
    // Hämta de förifyllda tecknen i #textarea
    var el = $("#textarea").get(0);

    // Kolla om #textarea existerar
    if (el == null) {
        console.log('Debug: id="textarea" does not exist');

    } else {

        // Räkna de förifyllda tecknen i #textarea
        var elemLen = el.value.length;

        // Placera markören i slutet av den förifyllda texten
        el.selectionStart = elemLen;
        el.selectionEnd = elemLen;
        el.focus();

        // Hämta maxlängden för ett svar ur påhittade HTML-attributet "max" i <textarea>
        var textLimit = el.getAttribute('name');


        // Funktionen för att hantera utfallet vid förändringar i textarea
        var handleChange = function() {
            var textLength = $('#textarea').val().length;
            var textRemaining = textLimit - textLength;

            $('#textareaFeedback').html(textRemaining);

            Next-knapp på/av

            if (textRemaining >= 0 && textRemaining < textLimit - elemLen) {
                $('#save').attr("disabled", false);
            } else {
                $('#save').attr("disabled", true);
            }

            // Räknarens färg röd/svart

            if (textRemaining < 0) {
                $('#textareaFeedback').css('color', 'red');
            } else {
                $('#textareaFeedback').css('color', '#aaa');
            }		
        };

        $('#textarea').bind('input propertychange', handleChange);
    }

    //handleChange(); */

});