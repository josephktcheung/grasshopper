class UsersController < ApplicationController
  respond_to :json

  before_action :get_user, only: [ :update, :destroy ]

  def index
    @users = if params[:id]
      User.where('id in (?)', params[:id].split(','))
    else
      User.all
    end
  end

  def create
    user = User.new user_params

    if user.save
      head :created, location: user_url(user)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @user.update(user_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @user.destroy ? :no_content : :unprocessable_entity
  end

  def profile
    if current_user.nil?
      head :unauthorized
    end
    @current_user_array = []
    @current_user_array << @current_user
  end

  protected

  def user_params
    params.require(:user).permit(:avatar, :id, :first_name, :last_name, :is_active, :email, :role)
  end

  def get_user
    head :not_found unless @user = User.where('id = ?', params[:id]).take
  end

end