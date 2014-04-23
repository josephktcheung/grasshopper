class ApprenticeshipsController < ApplicationController

  def index
    @apprenticeships = if params[:id]
      Apprenticeship.where('id in (?)', params[:id].split(','))
    else
      Apprenticeship.all
    end
  end
end