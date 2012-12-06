module ApplicationHelper
  def alert_css_class(type)
    case type
      when :alert
        "alert-block"
      when :error
        "alert-error"
      when :notice
        "alert-notice"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end
end
