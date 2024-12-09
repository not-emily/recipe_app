class ApplicationController < ActionController::Base
    def authenticate_user
        if session[:user_id] && session[:user_expiry_time]
          if session[:user_expiry_time] >= 12.hours.ago.to_s
            session[:user_expiry_time] = Time.current.to_s
            @current_user = User.find_by_apikey(session[:user_id])
          else
            @current_user = User.find_by_apikey(session[:user_id])
    
            # Reset session
            session[:user_id] = nil
            session[:user_expiry_time] = nil
            session[:current_user] = nil
            redirect_to signin_path
          end
        else
          redirect_to signin_path
        end
    end

end
