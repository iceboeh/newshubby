$(document).ready(function(){
	
	var showExample = function() {
		
		if (window.matchMedia('(max-width: 768px)').matches) {
			$('#intExample').show();
		} else {
			$('#intExample').hide();	

			// Fadea in text vid mouseover av bilden
			$('#hubert').mouseover(function() {
				$('#intExample').fadeIn(100);
			});
			
			
			//Fadea ut text vid mouseout av bilden med fördröjning
			$('#hubert').mouseleave(function() {
				// setTimeout(function() {
					$('#intExample').fadeOut(100);
				//}, 1000); // 1000ms = 1s delay
			});
			
		}
		
	};


	
	// Hämta och räkna de förifyllda tecknen i textarea
	
	var el = $("#textarea").get(0);
	var elemLen = el.value.length;
	
	// Placera markören i slutet av den förifyllda texten

	el.selectionStart = elemLen;
	el.selectionEnd = elemLen;
	el.focus();
	
	// Hämta maxlängden för ett svar ur påhittade HTML-attributet "max" i <textarea>

	var textLimit = el.getAttribute('max');
	
	
	// Funktionen för att hantera utfallet vid förändringar i textarea
	
	var handleChange = function() {
		var textLength = $('#textarea').val().length;
		var textRemaining = textLimit - textLength;

		$('#textareaFeedback').html(textRemaining);
		
		/* Next-knapp på/av */
		
		if (textRemaining >= 0 /*&& textRemaining < textLimit - elemLen*/) {
			$('#nextButton').attr("disabled", false);
		} else {
			$('#nextButton').attr("disabled", true);
		}
		
		// Räknarens färg röd/svart
		
		if (textRemaining < 0) {
			$('#textareaFeedback').css('color', 'red');
		} else {
			$('#textareaFeedback').css('color', '#aaa');
		}		
	};
	
	$('#textarea').bind('input propertychange', handleChange);
	
	showExample();
	
	// handleChange();

});