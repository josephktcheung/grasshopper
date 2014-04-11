class SessionController < ApplicationController

  def new
    redirect_to root_url, notice: "You are logged in." if current_user
  end

  def create
    if user_params[:password].blank?
      if user = User.find_by( email: user_params[:email] )
        PasswordResetter.new(flash).set_reset_code_and_notify_user(user)
      else
        UserRegisterer.new(flash).create_a_new_registrant(user_params[:email])
      end
    else
      user = UserAuthenticator.new(flash).authenticate_user(user_params)
      return if log_user_in_and_redirect( user )
    end

    render :new
  end

  def destroy
    log_user_out_and_redirect(login_form_url, "You've successfully logged out.")
  end

  private

  def user_params
    params.require(:user).permit( :email, :password )
  end
end
