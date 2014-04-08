require 'spec_helper'

describe Apprenticeship do

  describe "master" do
    it "should be valid with a master role"
  end

  describe "grasshopper" do
    it "should be valid with a grasshopper role"
  end

  describe "start_date" do
    it "should be valid with a start date"
    it "should not be valid without a start date"
  end

  describe "status" do
    it "should be active when a user starts an apprenticeship"
    it "should not be inactive when user starts and apprenticeship"
  end
end