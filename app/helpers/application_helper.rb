module ApplicationHelper
  def flash_messages
    flash_messages = ''

    flash.each do |type, message|
      flash_messages << content_tag(:p, message, class: "flash_#{type}", data: { type: type, closer: true })
    end

    flash_messages.html_safe
  end
end
