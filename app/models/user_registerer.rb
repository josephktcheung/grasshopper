class UserRegisterer

  SUCCESS = %{ We sent you an email with instructions for
    completing your registration.}.squish

  WELCOME = %{
    You have successfully completed your Grasshopper registration and
    are logged in. Welcome to Grasshopper!
  }.squish

  MAIL_FAILED = "Unable to send email. Please notify the webmaster."
  SAVE_FAILED = "Registration failed. Please notify the webmaster."

  def initialize(flash)
    @flash = flash
  end

  def create_a_new_registrant(email)
    @registrant = Registrant.find_or_initialize_by( email: email )

    if @registrant.save
      send_registration_coded_link
    else
      @flash.now[:alert] = SAVE_FAILED
    end
  end

  def create_new_user_from_registrant(registrant, user_params)
    params = user_params.merge( email: registrant.email )

    if user = User.create( params )
      registrant.destroy
      send_welcome_email(user)
    else
      @flash.now[:alert] = SAVE_FAILED
    end

    user
  end

  private

  def send_registration_coded_link
    begin
      UserNotifier.coded_registration_link(@registrant).deliver

      @flash.now[:notice] = SUCCESS
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      @flash.now[:alert] = MAIL_FAILED
    end
  end

  def send_welcome_email(user)
    begin
      UserNotifier.welcome(user).deliver
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      # Fail silently
    end
  end
end
