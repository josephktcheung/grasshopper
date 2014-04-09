class UserAuthenticator
  AUTH_FAILED = %{
    Unable to log you in.
    Please check your email and password and try again.
  }.squish

  def initialize(flash)
    @flash = flash
  end

  def authenticate_user(user_params)
    unless @user = User.authenticate(
        user_params[:email],
        user_params[:password]
      )

      @flash.now[:alert] = AUTH_FAILED
    end

    @user
  end
end
