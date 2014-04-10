require 'spec_helper'

describe Rating do

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @apprenticeship = Apprenticeship.create(master: @user1, apprentice: @user2, end_date: (-1.month.from_now))
    @rating = Rating.create(rater: @user1, ratee: @user2, apprenticeship: @apprenticeship, rating: 5)
  end

  it "should be valid with a rater, ratee, apprenticeship, and rating" do
    expect(@rating).to be_valid
  end

  it "should not be valid without an apprenticeship" do
    @rating.apprenticeship = nil
    expect(@rating).to_not be_valid
  end

  describe "rater and ratee" do
    it "should not be valid with the same rater and ratee" do
      @rating.rater = @rating.ratee
      expect(@rating).to_not be_valid
    end
    it "should not be valid without a rater" do
      @rating.rater = nil
      expect(@rating).to_not be_valid
    end
    it "should not be valid without a ratee" do
      @rating.ratee = nil
      expect(@rating).to_not be_valid
    end
  end

  describe "score" do
    it "should not be valid if the rating is less than 1" do
      @rating.rating = 0
      expect(@rating).to_not be_valid
    end
    it "should not be valid if the rating is greater than 5" do
      @rating.rating = 6
      expect(@rating).to_not be_valid
    end
  end

end