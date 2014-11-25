ready = ->
  setUpMarkdownSupport()

setUpMarkdownSupport = ->
  options = {
    editor: document.querySelector('[data-toggle="pen"]'),
    debug: false,
    list: [
      'blockquote', 'h2', 'h3', 'p', 'insertorderedlist', 'insertunorderedlist',
      'indent', 'outdent', 'bold', 'italic', 'underline', 'createlink'
    ]
  }

  # create editor
  pen = window.pen = new Pen(options);

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