/*jslint browser: true*/
/*global $, jQuery, alert*/



$(document).ready(function() {
    
    var $root = $('#q-container');
    $('a').click(function() {
        $root.animate({
            scrollTop: $( $.attr(this, 'href') ).offset().top
        }, 500);
        return false;
    });
    
    

    
    var textareaContent = $("#textarea").get();
        
    /* $('#save').click(function() {
         
            $('#span01').text($(this).val());
        });
    }); */
    
    // Visa intervju-exempel
    /* var showExample = function() {

        // Dölj exemplet från börja om viewporten är större än 768px bred
		if (window.matchMedia('(max-width: 768px)').matches) {
			$('#intExample').show();
		} else {
			$('#intExample').hide();	

			// Toggla text vid click av bilden
			$('#hubert').click(function() {
				$('#intExample').fadeToggle(100);
			});

            $('#closeIntExample').click(function() {
                $('#intExample').fadeOut(100);
            });
		}
	};

    showExample(); */

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

            /* Next-knapp på/av */

            if (textRemaining >= 0 /*&& textRemaining < textLimit - elemLen*/) {
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



        handleChange();
    }

});