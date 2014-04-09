require 'spec_helper'

describe Skill do

  before :each do
    @skill_invalid = Skill.create
    @skill_valid = Skill.create (skill_name: "Wood Carving")
  end

  context "has skill_name" do

    it "should be valid with a unique skill_name" do
      # @skill_unique = Skill.create (skill_name: "rails")
      # expect @skill_unique.to be_valid
    end

    it "should not be valid with a duplicate skill_name"

    it "should have all lowercase in skill_name"
  end

  context "does not have a skill_name" do

    it "should not be valid without a skill_name"
  end

end