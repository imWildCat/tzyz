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
    # Enable/disable at_user feature
    editor.on 'focus', (e) ->
      $.enable_at_user()
    # Control + Enter
    form.on 'keydown', (e) ->
      if (e.ctrlKey && e.keyCode == 13)
        form.find('input[type="submit"]').click()
    # Handle submit action
    form.submit ->
      form.find('[contenteditable="true"]').attr('contenteditable', 'false');
      form.find('input.content').val(editor.getValue())
      form.submit()
      return false

$(document).ready ready
$(document).on 'page:load', ready