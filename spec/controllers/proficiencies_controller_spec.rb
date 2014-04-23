require 'spec_helper'

describe ProficienciesController, :type => :api do

  render_views

  before :each do
    @user = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @skill = Skill.create(skill_name: 'electrician')
    @proficiency = Proficiency.create(proficiency_status: 'has', user: @user, skill: @skill)
  end

  describe 'GET index' do

    it "returns list of proficiencies" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["proficiencies"][0]["proficiency_status"]).to eq 'has'
      expect(JSON.load(response.body)["proficiencies"][0]["links"]["user"]["id"]).to eq @user.id
      expect(JSON.load(response.body)["proficiencies"][0]["links"]["skill"]["id"]).to eq @skill.id
    end

  end

end