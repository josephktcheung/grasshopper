class UsersController < ApplicationController
  respond_to :json

  before_action :get_user, only: [ :update, :destroy ]

  def index
    @users = User.all
  end

  def update
    if @user && @user.update_attributes(user_params)
      head :no_content
    else
      head :unprocessable_entity
    end
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

  private


  def user_params
    params.require(:user).permit(:avatar, :id, :first_name, :last_name, :is_active, :email, :role)
  end

  protected

  def get_user
    head :not_found unless @user = User.where('id = ?', params[:id]).take
  end

end