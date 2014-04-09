require 'spec_helper'

describe Conversation do
  before(:each) do
    @grasshopper = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @master = User.create(first_name: 'Master', last_name: 'Hopper', email: 'gm@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @conversation = Conversation.create(created_by: @grasshopper.id, created_for: @master.id)
  end

  it "should not valid without created_for" do
    @conversation.created_for = nil
    expect(@conversation).to_not be_valid
  end

  it "should not valid without created_at"
  it "should not valid without updated_at"
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