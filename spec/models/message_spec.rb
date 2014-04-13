require 'spec_helper'

describe Message do

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @conversation = Conversation.create(created_by: @user1, created_for: @user2)
    @message1 = Message.create(recipient: @user1, sender: @user2, conversation: @conversation, content: 'Content')
    @message2 = Message.create(recipient: @user2, sender: @user1, conversation: @conversation, content: 'Content')
  end

  it "should be valid with recipient, sender, conversation, and content" do
    expect(@message1).to be_valid
  end

  describe "recipient" do
    it "should not be valid without recipient" do
      @message1.recipient = nil
      expect(@message1).to_not be_valid
    end
  end

  describe "sender" do
    it "should not be valid without sender" do
      @message1.recipient = nil
      expect(@message1).to_not be_valid
    end
  end

  describe "conversation" do
    it "should not be valid without a conversation" do
      @message1.conversation = nil
      expect(@message1).to_not be_valid
    end
  end

  describe "content" do
    it "should not be valid without content" do
      @message1.content = nil
      expect(@message1).to_not be_valid
    end
    it "should be valid with special chars, line breaks, etc." do

    end
  end

  describe "sender" do
    it "should not be valid if sender is the same as recipient" do
      @message1.recipient = @message1.sender
      expect(@message1).to_not be_valid
    end
  end

end