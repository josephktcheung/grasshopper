require 'spec_helper'

describe Apprenticeship do

  describe "master" do
    it "should not have an existing active status with the grasshopper"
    it "should be valid with a user who has a master role"
    it "should not be valid without a user who has a master role"
  end

  describe "grasshopper" do
    it "should not have an existing active status with the master"
    it "should be valid with a user who has a grasshopper role"
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