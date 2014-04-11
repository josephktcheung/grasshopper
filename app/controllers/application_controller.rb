class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  before_filter :make_action_mailer_use_request_host_and_protocol

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def is_authenticated?
    redirect_to login_form_url unless current_user
  end

  def log_user_in_and_redirect(user)
    if user
      session[:user_id] = user.id
      redirect_to root_url
    end
  end

  def log_user_out_and_redirect(url, notice)
    session[:user_id] = nil
    redirect_to url, notice: notice
  end

  private

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
