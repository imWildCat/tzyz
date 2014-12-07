ready = ->
  setRichTextSupport()

setRichTextSupport = ->
  $('form.editor-form').each ->
    form = $(@)
    # Set up editor
    textarea = $(@).find('textarea.simditor')
    editor = new Simditor
      textarea: textarea
      toolbar: ['bold', 'italic', 'underline', 'strikethrough', 'ol', 'ul', 'blockquote', 'link', 'image', 'hr']
    # Handle submit action
    form.submit ->
      form.find('input.content').val(editor.getValue())
      form.submit()
      return false

$(document).ready ready
$(document).on 'page:load', ready