class ProficienciesController < ApplicationController

  def index
    @proficiencies = Proficiency.all
  end
end
