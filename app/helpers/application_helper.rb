module ApplicationHelper
    def bootstrap_class_for flash_type
        { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
      end
     
    def flash_messages(opts = {})
        flash.each do |msg_type, message|
          msg = ""
          #if its a hash, I want to hide the field name that failed
          if message.class == Hash
            message.each do |k, v|
              msg = msg + v[0] + " : "
            end
          else
           msg = message
          end
          concat(content_tag(:div, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
                  concat content_tag(:div, msg, class: "alert-text")
                end)
        end
        nil
    end

end
