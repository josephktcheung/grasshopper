require 'spec_helper'

describe Skills_Users do

    it "is not valid without a user_id"
    it "is not valid without a skill_id"

    context "user can only have a given skill once" do
        it "is not valid if a user_id is associated with a skill_id more than once"
    end

    context "many users with skills" do
      it "is valid if multiple users have the same skill"
    end
end 