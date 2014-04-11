class UsersController < ApplicationController

  def index
  end

  def destroy
    current_user.destroy
    log_user_out_and_redirect(root_url, "You've successfully deleted your account.")
  end
end