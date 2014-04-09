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

  it "should not valid without created_by" do
    @conversation.created_by = nil
    expect(@conversation).to_not be_valid
  end

  it "should update updated_at when new message is created" do
    previous_updated_at_time = @conversation.updated_at
    @conversation.messages.create(from_user: @grasshopper.id, to_user: @master.id)
    expect(Conversation.find(@conversation.id).updated_at).to_not eq previous_updated_at_time
  end

  describe "when created_by initiater" do
    describe "recipient" do
      it "should not be the same as initiater" do
        conversation = Conversation.new(created_by: @grasshopper.id, created_for: @grasshopper.id)
        conversation.save
        expect(conversation).to_not be_valid
      end

      it "should not have existing conversation with the initiater" do
        new_conversation_same_initiater = Conversation.create(created_by: @grasshopper.id, created_for: @master.id)
        new_conversation_different_initiater = Conversation.create(created_by: @master.id, created_for: @grasshopper.id)
        expect(new_conversation_same_initiater).to_not be_valid
        expect(new_conversation_different_initiater).to_not be_valid
      end
    end
  end

  describe "updated_at" do
    it "should be updated when a new message is created in this conversation"
  end
end