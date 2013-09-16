flash_message = (type, message, closer, hide, delay) ->
  delay = 5000 if typeof delay is "undefined"

  $.pnotify
    type: type
    text: message
    shadow: false
    history: false
    sticker: false
    icon: false
    width: '400px'
    closer: closer
    delay: delay
    hide: hide
    before_open: ($pnotify) ->
      $pnotify.find('.ui-pnotify-closer').html('×')

$ ->
  $(".flash_error, .flash_notice, .flash_success, .flash_info, .flash_alert").each ->
    flash_message $(this).data("type"), $(this).html(), $(this).data("closer"), $(this).data("hide")
