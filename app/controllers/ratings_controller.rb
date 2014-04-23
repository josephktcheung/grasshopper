class RatingsController < ApplicationController

  def index
    @ratings = if params[:id]
      Rating.where('id in (?)', params[:id].split(','))
    else
      Rating.all
    end
  end
end