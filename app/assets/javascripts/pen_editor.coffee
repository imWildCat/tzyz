ready = ->
  # placeholder
  $('div[data-toggle="pen"]').html('')
  $('div[data-toggle="pen"]').addClass('pen-placeholder')

  $('div[data-toggle="pen"]').focus ->
   $(@).removeClass('pen-placeholder')
  $('div[data-toggle="pen"]').blur ->
    $(@).addClass('pen-placeholder') if $(@).html().length == 0

  $('.pen-form').submit ->
   $(@).find('input[name="content"]').val($(@).find('div[data-toggle="pen"]').html())
   $(@).submit()
   return false

$(document).ready ready
$(document).on 'page:load', ready