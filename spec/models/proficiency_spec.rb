require 'spec_helper'

describe Skills_Users do

  it "should not be valid without a user_id"
  it "should not be valid without a skill_id"

  context "user can only have a given skill once" do
    it "should not be valid if a user_id is associated with a skill_id more than once"

  end
end