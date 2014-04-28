class SkillsController < ApplicationController
  respond_to :json
  before_action :get_user
  before_action :get_skill, only: [ :update, :destroy ]

  def index
    @skills = if params[:id]
      Skill.where("id in (?) #{@user_clause}", params[:id].split(','))
    else
      @user ? @user.skills : Skill.all
    end

    @proficiencies = (@skills.map { |skill| skill.proficiencies }).flatten.sort.uniq
  end

  def create
    skill = Skill.new skill_params

    if skill.save
      head :created, location: skill_url(skill), id: skill.id
    else
      head :unprocessable_entity
    end
  end

  def update
    head @skill.update(skill_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @skill.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def skill_params
    params.require(:skill).permit(:skill_name)
  end

  def get_user
    if params[:user_id]
      head :bad_request unless @user = User.where('id = ?', params[:user_id]).take
    end
    @user_clause = @user ? "and user_id = #{@user.id}" : ""
  end

  def get_skill
    head :not_found unless @skill = skill.where('id = ?', params[:id]).take
  end
end