$ ->
  $('#preview_post_button').click ->
    $('#preview_post').css('display', '')
    $('#preview_post .preview_post').html($('.redactor_redactor').html())
