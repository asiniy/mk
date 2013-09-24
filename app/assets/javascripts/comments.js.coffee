$ ->
  $('.comment_here').click ->
    # removing css settings
    $('.comment_place').css('background', 'white')
    $('.comment_here').css('display', '')

    # adding css settings for current_comment
    $(this).closest('.comment_place').css('background', '#ffefd5')
    $(this).css('display', 'none')

    # changing form
    if $(this).data('parent_id') == undefined
      $('#new_comment').appendTo($(this).siblings('.new_comment'))
      $('#new_comment').find('#comment_parent_id').removeAttr('value')
    else
      $('#new_comment').appendTo($(this).closest('.comment'))
      $('#new_comment').find('#comment_parent_id').val($(this).data('parent_id'))

$ ->
  $("#new_comment").bind "ajax:success", (e, data, status, xhr) ->
    if data.success == true
      console.log('saved!')
    else
      console.log('zzz')
