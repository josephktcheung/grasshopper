class UserNotifier < ActionMailer::Base
  default from: "Grasshopper <webmaster@grasshopper.com>"

  CODED_RESET_LINK          = "[Grasshopper] Reset your credentials"
  PASSWORD_WAS_RESET        = "[Grasshopper] Your password has been reset!"
  CODED_REGISTRATION_LINK   = "[Grasshopper] Complete your registration"
  WELCOME_NEW_USER          = "[Grasshopper] Welcome to Grasshopper!"

  def coded_password_reset_link(user)
    @user = user

    mail to: @user.email, subject: CODED_RESET_LINK
  end

  def password_was_reset(user)
    @user = user

    mail to: @user.email, subject: PASSWORD_WAS_RESET
  end

  def coded_registration_link(registrant)
    @registrant = registrant

    mail to: @registrant.email, subject: CODED_REGISTRATION_LINK
  end

  def welcome(user)
    @user = user

    mail to: @user.email, subject: WELCOME_NEW_USER
  end
end
