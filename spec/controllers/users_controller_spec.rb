require 'spec_helper'

describe UsersController do

  render_views

  before :each do
    User.create(email: 'simon@ga.com', password: '123', password_confirmation: '123')
  end

  describe 'GET index' do
    it "returns list of users" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(response.body).to include 'simon@ga.com'
      expect(JSON.load(response.body)["users"][0]["email"]).to eq 'simon@ga.com'
    end
  end



end