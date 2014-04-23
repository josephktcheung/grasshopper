class ApprenticeshipsController < ApplicationController

  def index
    @apprenticeships = Apprenticeship.all
  end
end