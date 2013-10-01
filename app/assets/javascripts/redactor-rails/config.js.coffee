redactorReady = ->
  console.log($('.redactor_box').length())
  if $('.redactor_box').length() == 0
    csrf_token = $("meta[name=csrf-token]").attr("content")
    csrf_param = $("meta[name=csrf-param]").attr("content")
    params = undefined
    params = csrf_param + "=" + encodeURIComponent(csrf_token)  if csrf_param isnt `undefined` and csrf_token isnt `undefined`
    $(".redactor").redactor
      imageUpload: "/redactor_rails/pictures?" + params
      imageGetJson: "/redactor_rails/pictures"
      fileUpload: "/redactor_rails/documents?" + params
      fileGetJson: "/redactor_rails/documents"
      path: "/assets/redactor-rails"
      css: "style.css"
      minHeight: 200
      buttons: ["html", "|", "formatting", "|", "bold", "italic", "deleted", "|", "video", "image"]
      formattingTags: ["h3", "p"]

$(document).ready(redactorReady)
$(document).on('page:load', redactorReady)
