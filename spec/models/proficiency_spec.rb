require 'spec_helper'

describe Proficiency do

  before :each do
    @user = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @skill = Skill.create(skill_name: 'electrician')
    @proficiency = Proficiency.create(proficiency_status: 'has', user: @user, skill: @skill)
  end

  it "should not be valid without a user_id" do
    @proficiency.user = nil
    @proficiency.save
    expect(@proficiency).to_not be_valid
  end

  it "should not be valid without a skill_id" do
    @proficiency.skill = nil
    @proficiency.save
    expect(@proficiency).to_not be_valid
  end

  # describe User do
  #   context "user can only have a given skill once" do
  #   it "should not have the same skill with the same status" do

    end
  end
end