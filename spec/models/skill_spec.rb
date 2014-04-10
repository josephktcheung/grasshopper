require 'spec_helper'

describe Skill do

  before :each do
    @skill = Skill.create(skill_name: "Wood Carving")
  end

  describe "skill_name" do

    context "has skill_name" do
      it "should be valid with a unique skill_name" do
        @skill.save
        expect(@skill).to be_valid
      end
    end

      it "should not be valid with a duplicate skill_name" do
        second = Skill.create(skill_name: "wood carving")
        expect(second).to_not be_valid
      end

    context "does not have a skill_name" do
      it "should not be valid without a skill_name" do
        second = Skill.create
        expect(second).to_not be_valid
      end
    end
  end
end