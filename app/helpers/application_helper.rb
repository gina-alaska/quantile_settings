module ApplicationHelper
  def show_flash_messages
    output = []
    flash.each do |type, message|
      output << "<div class=\"alert alert-#{type}\">#{message}</div>"
    end
    output.join("<br />").html_safe
  end
end

