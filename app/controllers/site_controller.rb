class SiteController < ApplicationController
  before_action :is_authenticated?, except: [:privacy, :terms]

  def index
    @users = User.all.entries
  end

  def privacy
  end

  def terms
  end
end