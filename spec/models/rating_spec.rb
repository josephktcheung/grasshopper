require 'spec_helper'

describe Rating do

  describe "apprenticeship_id" do
    it "should be valid with an apprenticeship_id"
    it "should not be valid without an apprenticeship_id"
  end

  describe "rated_by" do
    it "should log who the rating is by"
  end

  describe "assigned_to" do
    it "should assign the rating to the correct user"
  end

  describe "score" do
    it "it should update the score when the user is rated"
  end
end