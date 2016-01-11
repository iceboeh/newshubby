/*jslint browser: true*/
/*global $, jQuery, alert*/

$(document).ready(function() {

    var i = 1; // counter starting at 1
    var qCount = $('.question').length; // count the number of .question divs
    //console.log('There are ' + qCount + ' question divs present'); // log number of .question in console. Sanity check.

    var hideModal = function() {
        $('.overlay').hide(); // hide any dimmed modal background
        $('[id^=modal]').hide(); // hide any hint modal
    };

    jQuery.fn.putCursorAtEnd = function() {

        return this.each(function() {

            $(this).focus()

            // If this function exists...
            if (this.setSelectionRange) {
                // ... then use it (Doesn't work in IE)

                // Double the length because Opera is inconsistent about whether a carriage return is one character or two. Sigh.
                var len = $(this).val().length * 2;

                this.setSelectionRange(len, len);

            } else {
                // ... otherwise replace the contents with itself
                // (Doesn't work in Google Chrome)

                $(this).val($(this).val());

            }

            // Scroll to the bottom, in case we're in a tall textarea
            // (Necessary for Firefox and Google Chrome)
            this.scrollTop = 999999;
        });
    };

    var focusPls = function(){
        $('#q' + i + ' textarea').focus(); // put cursor in textarea
        $('#q' + i + ' input[type=text]:first').focus(); // put cursor in first text input field
        if (i > 1) {
            $('#q' + i + ' textarea').putCursorAtEnd(); // put cursor at end of textarea
            $('#q' + i + ' input[type=text]:first').putCursorAtEnd(); // put cursor at end of text input field
        };
    };

    var animateDown = function(){
        $('[id^=q]' + ' .row').not('#q' + i).removeClass('animated fadeInDown fadeInUp'); //remove fade and slide effect classes on all but THIS question
        $('#q' + i + ' .row').addClass('animated fadeInDown'); //add fade and slideDown effect classes on this THIS question
    };

    var animateUp = function(){
        $('[id^=q]' + ' .row').not('#q' + i).removeClass('animated fadeInDown fadeInUp'); //remove fade and slide effect classes on all but THIS question
        $('#q' + i + ' .row').addClass('animated fadeInUp');  //add fade and slideUp effect classes on this THIS question
    };

    var handleBtns = function() {
        if (i == 1) {
            $('#prev').hide();
        }
        else {
            $('#prev').show();
        }

        if (i == qCount) {
            $('#next').hide();
            $('#distribute').show();
            $('.edit_press_release').removeAttr('data-remote') // Something to do with rails... Ask back end ppl ;-)
        } else {
            $('#next').show();
            // $('#distribute').hide();
        }
    };

    handleBtns();

    var skipQuestions = function() {

        $('#q' + i).show(); // show the question equivalent to the global counter (i), in this case probably question 1
        activeBtn();

        $('#next').click(function(){ // NEXT-button when clicked
            if ( i < qCount ){ // if i is less than the number of questions...
                i ++; // add 1 to our global counter
                //console.log(i); // print out the global counter value in console (sanity check)
                $('[id^=q].question').not('#q' + i).hide(); // hide all #q that don't have the current global counter value
                //console.log('hiding'); // sanity check
                $('#q' + i).show(); // display the #q plus global counter value (e.g. #q2)
                // console.log('showing'); // sanity check
                hideModal();
                activeBtn();
                focusPls();
                handleBtns();
                //animateUp();
                saving();
            }
        });

        $('#prev').click(function(){ // PREV-button when clicked
            if (i > 1) { // if i is bigger than 1 do...
                i --; // subtract 1 from global counter
                //console.log(i); // print out the global counter value in console (sanity check)
                $('[id^=q].question').not('#q' + i).hide(); // hide all #q that don't have the current global counter value
                //console.log('hiding'); // sanity check
                $('#q' + i).show(); // display the #q plus global counter value (e.g. #q2)
                // console.log('showing'); // sanity check
                hideModal();
                activeBtn();
                focusPls();
                handleBtns();
                //animateDown();
                saving();
            }
            if (i == 1) {
                $('#prev').hide();
            }
        });

        /* $('.panel').keydown(function(e) {
            if (e.keyCode == 13){
                e.preventDefault();
                $("#next").click();
            } //enter
        }); */
    };

    var handleHints = function() {

        $(document).keyup(function(e) {
            if (e.keyCode == 27) {
                $('.overlay').hide();
                $('#modal' + i).hide();
            }   // esc
        });

        $('.hints').click(function(){
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
            $('[id^=q].question').not('#q' + $(this).data('id')).hide(); // hide all #q that don't have the current global counter value
            $('[id^=q]' + ' .row').removeClass('animated fadeInDown fadeInUp'); // Remove fade and slide effects on all questions
            hideModal();
            $('#q'+$(this).data('id')).show();
            i = $(this).data('id');
            activeBtn();
            focusPls();
            handleBtns();
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

    function saved(){
        $('.saveStatus').hide();
        $('.saved').show();

        setTimeout(function(){ 
            $('.saved').fadeOut(240);  
        }, 1000);
    }

    $('.pr-container').bind("DOMSubtreeModified", saved); // Listen for DOM changes

    var saving = function() {
        $('.saveStatus').hide();
        $('.saving').show();

        setTimeout(function(){ 
            $('.saving').fadeOut(240);  
        }, 30000);
    };
});