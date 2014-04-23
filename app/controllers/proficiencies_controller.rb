class ProficienciesController < ApplicationController

  def index
    @proficiencies = if params[:id]
      Proficiency.where('id in (?)', params[:id].split(','))
    else
      Proficiency.all
    end
  end
end
