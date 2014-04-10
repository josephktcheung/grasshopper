require 'spec_helper'

describe Rating do

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @apprenticeship = Apprenticeship.create(master: @user1, apprentice: @user2, end_date: (-1.month.from_now))
    @rating = Rating.create(rater: @user1.id, ratee: @user2.id, apprenticeship: @apprenticeship)
  end

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