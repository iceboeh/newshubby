# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	#$ ->
	#	$(window).scroll ->
	#		url = $('.pagination .next_page').attr('href')
	#		if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
	#			$('.pagination').text('Fetching more press releases...')
	#			$.getScript(url)
	$ ->
	  $container = $('#masonry-container')
	  $container.imagesLoaded ->
	    $container.masonry
	      itemSelector: '.brick'
	      #columnWidth: 100
	    return
	  $container.infinitescroll {
	    navSelector: '.pagination'
	    nextSelector: '.pagination .next_page'
	    itemSelector: '.brick'
	    loading:
	      finishedMsg: 'No more press releases to load.'
	      img: '/assets/masonry/loader.gif'
	  }, (newElements) ->
	    # hide new items while they are loading
	    $newElems = $(newElements).css(opacity: 0)
	    # ensure that images load before adding to masonry layout
	    $newElems.imagesLoaded ->
	      # show elems now they're ready
	      $newElems.animate opacity: 1
	      $container.masonry 'appended', $newElems, true
	      return
	    return
	  return
					
	$ ->
		  $container = $("#masonry-container")
		  $container.imagesLoaded ->
		    $container.masonry
			    itemSelector: ".brick"
			    gutterWidth: 0
			    isFitWidth: true
					isAnimated: !Modernizr.csstransitions
			  return
				
###	
  subscription.setupForm()

subscription =
  setupForm: ->
    $('#new_subscription').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        subscription.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      exp_month: $('#card_month').val()
      exp_year: $('#card_year').val()
    paymill.createToken(card, subscription.handlePaymillResponse)
  
  handlePaymillResponse: (error, result) ->
    if error
      $('#paymill_error').text(error.apierror)
      $('input[type=submit]').attr('disabled', false)
    else
      $('#subscription_paymill_card_token').val(result.token)
      $('#new_subscription')[0].submit()
###	
	
			
