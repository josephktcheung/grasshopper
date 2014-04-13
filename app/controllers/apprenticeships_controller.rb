class ApprenticeshipsController < ApplicationController

  def index
    @apprenticeships = Apprenticeship.all
  end

  def show
    @apprenticeship = Apprenticeship.find(params[:id])
  end
end