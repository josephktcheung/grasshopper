class ProficienciesController < ApplicationController
  def index
    @proficiencies = Proficiency.all
  end

  def show
    @proficiency = Proficiency.find(params[:id])
  end
end
