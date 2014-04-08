require 'spec_helper'

describe Conversation do
  before(:each) do
    user.create(email: "initiater@ga.co", password: "1234", password_confirmation: "1234")
    user.create(email: "recipient@ga.co", password: "1234", password_confirmation: "1234")
  end

  it "should not valid without created_for"
  it "should be valid with created_for"
  it "should not valid without created_at"
  it "should be valid with created_at"
  it "should not valid without updated_at"
  it "should be valid with updated_at"
  it "should update updated_at when new message is created"

  describe "created_by initiater" do
    it "should not valid without created_by"
    it "should be valid with created_by"

    describe "recipient" do
      it "should not be the same as initiater"
      it "should not have existing conversation with the initiater"
    end
  end

  describe "updated_at" do
    it "should be updated when a new message is created in this conversation"
  end
end