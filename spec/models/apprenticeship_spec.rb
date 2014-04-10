require 'spec_helper'

describe Apprenticeship do

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @apprenticeship = Apprenticeship.create(master: @user1, apprentice: @user2, end_date: 1.second.from_now)
    @rating = Rating.create(rater: @user1, ratee: @user2, apprenticeship: @apprenticeship, rating: 5)
  end

  it "should be valid with a master, apprentice, and end_date" do
    expect(@apprenticeship).to be_valid
  end

  it "should not be a duplicate relationship" do
    @apprenticeship2 = Apprenticeship.new(master: @user1, apprentice: @user2)
    expect(@apprenticeship2.save).to be_false
  end

  describe "master" do
    it "should not be valid without a user who has a master role" do
      @user1.role = 'apprentice'
      expect(@apprenticeship).to_not be_valid
    end
  end

  describe "apprentice" do
    it "should not be valid without a user who has a apprentice role" do
      @user2.role = 'master'
      expect(@apprenticeship).to_not be_valid
    end
  end

  describe "end_date" do
    it "should be valid without an end date" do
      @apprenticeship.end_date = nil
      expect(@apprenticeship).to be_valid
    end
    it "should not have an end_date before the start_date field" do
      @apprenticeship.end_date = Time.now - 1.day
      expect(@apprenticeship).to_not be_valid
    end
  end

end