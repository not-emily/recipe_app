class WelcomeController < ApplicationController
  layout :resolve_layout


  def index
    @recipes = Recipe.for_user(@current_user)
  end

  def signin
  end

  def signin_do
    user = User.auth(params[:email], params[:password])
    if user
      session[:current_user] = user
      session[:user_id] = user.apikey
      session[:user_expiry_time] = Time.current.to_s
      if session[:last_page]
        url = session[:last_page].split('/')
        id = url[2]
        if url[1]=="booking" && id
          booking_pages = [booking_step_1_path(id), booking_step_2_path(id), booking_step_3_path(id), booking_step_4_path(id)]
          if booking_pages.include? session[:last_page]
            path = recipes_path
          else
            path = session[:last_page]
          end
        else
          path = session[:last_page]
        end
      else
        path = recipes_path
      end
      redirect_to path
    else
      flash[:error] = "Your email or password was incorrect."
      redirect_to signin_path
    end
  end

  def signup
  end

  def signup_do
    user = User.new(user_params)
    if params[:password] == params[:password_confirmation]
      if user.save
        flash[:notice] = "You can now sign in."
        redirect_to signin_path
      else
        flash[:error] = user.errors.full_messages
        redirect_to signin_path
      end
    else
      flash[:error] = "Password and confirmation do not match."
      redirect_to signup_path
    end
  end

  def signout
    session[:current_user] = nil
    session[:user_id] = nil
    session[:user_expiry_time] = nil
    flash[:error] = "You have been signed out."
    redirect_to signin_path
  end


  def reset_password
  end

  def forgot_password
  end


    #Google Sign In Callback
  #called from fetch in auth layout
  def gsi
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: Figaro.env.google_client_id)
    response = EDSAPI.gsi(payload, Figaro.env.eds_client_id)
    if response
      p "RESPONSE"
      p response
      decoded = JsonWebToken.jwt_decode(response["user"]["jwt"]) # decode the jwt
      validated = JsonWebToken.validate(decoded) # see if its expired

      if validated
        response = {token: decoded["user_key"]}
      else
        response = {error: "There was a problem with your authentication"}
      end

    else
      response = {error: "There was a problem with your authentication"}
      status = 400
    end

    render json: response
  end



  # From auth layout durring a successful gsi auth
  def gsi_session
    response = EDSAPI.get_user(params[:user_apikey], Figaro.env.eds_client_id) # get user data from api
    decoded = JsonWebToken.jwt_decode(response["user"]["jwt"]) # decode the jwt
    validated = JsonWebToken.validate(decoded) # see if its expired

    # Set user session
    session[:user] = decoded
    session[:user_name] = decoded["name"]
    session[:user_email] = decoded["email"]
    session[:jwt] = response["user"]["jwt"]
    session[:expiry_time] = Time.current.to_s
    session[:accounts] = response["accounts"]

    redirect_to select_domain_path # user selects a domain
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :mobile, :password, :password_confirmation)
  end

  def resolve_layout
    if action_name == "index"
      "application"
    else
      "auth"
    end
  end

end