# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('.best_in_place').best_in_place()

$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  event.preventDefault()	
    
$(document).ready ->
  $('#prStateBtn').click ->
    $('.prState').toggleClass 'text-info text-primary'
    $('#prStateBtn').toggleClass 'btn-info btn-primary'
    $('.prLink').toggleClass 'hidden'
    $('.prStateText').text (i, v) ->
      if v == 'unlisted' then 'public' else 'unlisted'
    return
  return