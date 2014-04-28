class ApprenticeshipsController < ApplicationController

  respond_to :json
  before_action :get_user
  before_action :get_apprenticeship, only: [ :update, :destroy ]
  before_action :get_user

  def index
    @apprenticeships = if params[:id]
      Apprenticeship.where("id in (?) #{@user_clause}", params[:id].split(','))
    else
      @user ? Apprenticeship.involve_user(@user) : Apprenticeship.all
    end
    @users = (@apprenticeships.map { |apprenticeship| [apprenticeship.master, apprenticeship.apprentice] }).flatten.sort.uniq
    @ratings = (@apprenticeships.map { |apprenticeship| apprenticeship.ratings }).flatten.sort.uniq
  end


  def create
    apprenticeship = Apprenticeship.new apprenticeship_params.merge(end_date: DateTime.new(6012,2,3))

    if apprenticeship.save
      head :created, location: apprenticeship_url(apprenticeship)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @apprenticeship.update(apprenticeship_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @apprenticeship.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def get_user
    if params[:user_id]
      head :bad_request unless @user = User.where("id = ?", params[:user_id]).take
    end
    @user_clause = if @user && @user.role == 'master'
      "and master_id = #{@user.id}"
    elsif @user && @user.role == 'apprentice'
      "and apprentice_id = #{@user.id}"
    else
      ''
    end
  end

  def apprenticeship_params
    params.require(:apprenticeship).permit(:master_id, :apprentice_id, :end_date)
  end

  def get_apprenticeship
    head :not_found unless @apprenticeship = Apprenticeship.where('id = ?', params[:id]).take
  end

end