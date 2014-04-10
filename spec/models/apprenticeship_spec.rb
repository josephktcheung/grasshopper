require 'spec_helper'

describe Apprenticeship do

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @apprenticeship = Apprenticeship.create(master: @user1, apprentice: @user2, end_date: (-1.month.from_now))
    @rating = Rating.create(rater: @user1.id, ratee: @user2.id, apprenticeship: @apprenticeship)
  end

  describe "master" do
    it "should not have an existing active status with the grasshopper"
    it "should not be valid without a user who has a master role"
  end

  describe "grasshopper" do
    it "should not have an existing active status with the master"
    it "should not be valid without a user who has a grasshopper role"
  end

  describe "start_date" do
    it "should not be valid without a start_date field"
  end

  describe "end_date" do
    it "should not have an end_date before the start_date field"
  end

  describe "is_active" do
    context "has start_date field" do
      it "should be true when end_date is nil"
      it "should be false when there is an end_date"
    end
  end
end