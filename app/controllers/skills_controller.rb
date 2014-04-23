class SkillsController < ApplicationController

  def index
    @skills = if params[:id]
      Skill.where('id in (?)', params[:id].split(','))
    else
      Skill.all
    end
  end
end