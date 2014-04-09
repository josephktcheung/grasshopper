require 'spec_helper'

describe Rating do

  describe "apprenticeship_id" do
    it "should not be valid without an apprenticeship_id"
  end

  describe "rated_by" do
    it "should not have a user id the same as the assigned_to id"
    it "should contain the user_id of the master or grasshopper of the associated apprenticeship"
  end

  describe "assigned_to" do
    it "should not have a user id the same as the rated_by id"
    it "should contain the user_id of the master or grasshopper of the associated apprenticeship"
  end

  describe "score" do
    it "should not be less than 1"
    it "should not be greater than 5"
  end
end