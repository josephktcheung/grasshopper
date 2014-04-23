class ProficienciesController < ApplicationController

  respond_to :json

  before_action :get_proficiency, only: [ :update, :destroy ]

  def index
    @proficiencies = if params[:id]
      Proficiency.where('id in (?)', params[:id].split(','))
    else
      Proficiency.all
    end
  end

  def create
    proficiency = Proficiency.new proficiency_params

    if proficiency.save
      head :created, location: proficiency_url(proficiency)
    else
      head :unprocessable_entity
    end
  end

  def update
    head @proficiency.update(proficiency_params) ? :no_content : :unprocessable_entity
  end

  def destroy
    head @proficiency.destroy ? :no_content : :unprocessable_entity
  end

  protected

  def proficiency_params
    params.require(:proficiency).permit()
  end
  def get_proficiency
    head :not_found unless @proficiency = Proficiency.where('id = ?', params[:id]).take
  end
end
