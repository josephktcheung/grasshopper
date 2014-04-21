module ApplicationHelper

  def flash_noty_script_tag
    javascript_tag(
      %{
        $(function() {
          #{ flash_to_noties.compact.join(" ") }
        });
      }.squish
    ) unless flash.empty?
  end

  private

  def get_type(name)
    name == :notice ? "success" : "error"
  end

  def get_timeout(name)
    name == :notice ? 4000 : 30000
  end

  def errors_to_ul(errors)
    content_tag(:ul,
      errors.to_a.map do |message|
        content_tag( :li, message ) unless message.blank?
      end.compact.join.html_safe
    ) unless errors.empty?
  end

  def get_text(message)
    message.is_a?(ActiveModel::Errors) ? errors_to_ul(message) : message
  end

  def flash_to_noties
    flash.map do |name, message|
      if message.is_a?(String) || message.is_a?(ActiveModel::Errors)
        get_noty_call get_type(name), get_timeout(name), get_text(message)
      end
    end
  end

  def get_noty_call(type, timeout, text)
    %{
      noty({
        layout: "top",
        type: "#{type}",
        timeout: "#{timeout.to_s}",
        text: "#{text}"
      });
    }.squish
  end

  def show_active
    if current_user.is_active
      "<span class='label label-success'>Active</span>"
    else
      "<span class='label label-danger'>In-Active</span>"
    end
  end

  def star_rating rating
    "<span class='glyphicon glyphicon-star'></span>" * rating
  end
end
