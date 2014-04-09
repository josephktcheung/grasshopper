class RegistrationController < ApplicationController
  before_action :get_registrant

  REGISTRANT_NOT_FOUND = %{
    Registration code not found or expired.
    Please try again.
  }.squish

  def new
    @user = User.new email: @registrant.email
  end

  def create
    if @user = UserRegisterer.new(flash).create_new_user_from_registrant(
        @registrant, user_params
      )

      log_user_in_and_redirect( @user )
    else
      flash.now[:alert] = @user.errors
      render :new
    end
  end

  private

  def get_registrant
    unless @registrant = Registrant.find_by_code( params[:code] )
      redirect_to login_form_url, alert: REGISTRANT_NOT_FOUND
    end
  end

  def user_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :role
    )
  end
end
