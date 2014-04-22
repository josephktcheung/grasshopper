class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    current_user.destroy
    log_user_out_and_redirect(root_url, "You've successfully deleted your account.")
  end

  def profile
    if current_user.nil?
      head :unauthorized
    end
    @current_user_array = []
    @current_user_array << @current_user
  end
end