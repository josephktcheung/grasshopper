require 'spec_helper'

describe UsersController, :type => :api do

  render_views

  before :all do
    User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
  end

  describe 'GET index' do

    it "returns list of users" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["users"][0]["email"]).to eq 'gh@ga.co'
      expect(JSON.load(response.body)["users"][0]["first_name"]).to eq 'Grass'
      expect(JSON.load(response.body)["users"][0]["last_name"]).to eq 'Hopper'
      expect(JSON.load(response.body)["users"][0]["last_name"]).to eq 'Hopper'
    end


  end

  describe "GET show" do

    it "return specific user" do
      get :show, id: 1, format: :json
      expect(response.status).to eq 200
    end

  end
end