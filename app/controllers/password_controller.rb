class PasswordController < ApplicationController
  PASSWORD_RESET_SUCCESSFUL = "Your password has been successfully reset."

  USER_NOT_FOUND = %{ Sorry, your reset link has expired.
    Please generate a new one.}.squish

  def edit
    unless @user = User.find_by_code( params[:code] )
      redirect_to login_form_url, notice: USER_NOT_FOUND
    end
  end

  def update
    if @user = User.find_by_code( params[:code] )
      resetter = PasswordResetter.new(flash)

      if resetter.update_password( @user, user_params )
        flash[:notice] = PASSWORD_RESET_SUCCESSFUL
        log_user_in_and_redirect( @user )
      else
        flash.now[:alert] = @user.errors
        render :edit
      end
    else
      redirect_to login_form_url, alert: USER_NOT_FOUND
    end
  end

  private

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end
