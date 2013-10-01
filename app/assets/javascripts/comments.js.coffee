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
      $('#new_comment').appendTo($(this).siblings('.new_comment'))
      $('#new_comment').find('#comment_parent_id').val($(this).data('parent_id'))

$ ->
  $('#new_comment').bind 'ajax:success', (e, data, status, xhr) ->
    $('#new_comment .errors').empty

    if data.success == true
      # empty form
      $('#new_comment #comment_author_name').val('')
      $('#new_comment .redactor').redactor('set', '')

      # clone and change comment
      resultComment = $('#comment_example .comment').clone()
      console.log(data['name'])
      resultComment.find('p strong').val(data['name'])
      resultComment.find('.comment_div').html($(data['content']))
      resultComment.find('.comment_here').remove()
      resultComment.find('.new_comment').remove()
      resultComment.find('.destroy_comment').remove()

      # set up css
      $('.comment_place').css('background', '')
      $('.comment_here').css('display', '')
      $('.comment_here:first').css('display', 'none')

      # rendering comment & moving form
      if $('#new_comment').find('#comment_parent_id').val().length == 0
        resultComment.prependTo($('#new_comment').parent().siblings('.comments'))
      else
        resultComment.prependTo($('#new_comment').closest('.comment').children('.comments'))
        $('#new_comment').appendTo($('.new_comment:first'))

      $('#new_comment').find('#comment_parent_id').removeAttr('value')
    else
      $('#new_comment .errors').html($(data.errors))

$ ->
  $('.destroy_comment').click ->
    commentDiv = $(this).closest('.comment')
    $.ajax $(this).data('uri'),
      type: 'DELETE',
      success: (data, textStatus, jqXHR) ->
        if data['success']
          commentDiv.remove()
