require 'spec_helper'

describe SkillsController, :type => :api do

  render_views

  before :each do
    @skill = Skill.create(skill_name: "Wood Carving")
  end

  describe 'GET index' do

    it "returns list of skills" do
      get :index, :format => :json
      expect(response.status).to eq 200
      expect(JSON.load(response.body)["skills"][0]["skill_name"]).to eq 'wood carving'
    end

  end

  describe "GET show" do

    it "return specific skill" do
      get :show, id: Skill.first.id, :format => :json
      expect(response.status).to eq 200
    end

  end
end