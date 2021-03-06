# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  setUpQuotedReply()
  handleAnchor()
  enableChosen()

$(document).ready ready
$(document).on 'page:load', ready

setUpQuotedReply = ->
  # Handle quote reply action
  $('.replies .action.quote-reply').click ->
    reply_id = $(@).attr('data-id')
    quoted_reply = $('#reply_' + reply_id)

    # Handle the UI
    $('#reply-form blockquote .author').html(quoted_reply.find('.author').html())
    $('#reply-form blockquote .time').html(quoted_reply.find('.time').html())
    $('#reply-form blockquote .content').html(quoted_reply.find('.content').html())
    $('#reply-form .quoted-reply').show()

    # Set the form value
    $('#reply-form input[name="quoted_reply_id"]').val(reply_id)

    $('#reply-form').scrollToMe()
    return false

  # Handle cancel button
  $('#reply-form .cancel').click ->
    $('#reply-form input[name="quoted_reply_id"]').val('')
    $('#reply-form .quoted-reply').hide()
    return false

handleAnchor = ->
  anchor = window.location.hash.substring(1)
  $('#' + anchor).addClass 'highlight'

enableChosen = ->
  # enable chosen for node select box
  $('.node-selector').chosen
    allow_single_deselect: true
    no_results_text: '未找到节点'
    width: '100%'