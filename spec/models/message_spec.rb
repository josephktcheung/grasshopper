require 'spec_helper'

describe Message do

  before :each do
    @user1 = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
    @user2 = User.create(first_name: 'App', last_name: 'Rentice', email: 'ap@ga.co', password: '123', password_confirmation: '123', role: 'apprentice')
    @conversation = Conversation.create(created_by: @user1.id, created_for: @user2.id)
    @message1 = Message.create(to_user: @user1, from_user: @user2, conversation: @conversation, content: 'Content')
    @message2 = Message.create(to_user: @user2, from_user: @user1, conversation: @conversation, content: 'Content')
  end

  it "should be valid with to_user, from_user, conversation, and content" do
    expect(@message1).to be_valid
  end

  describe "to_user" do
    it "should not be valid without to_user" do
      @message1.to_user = nil
      expect(@message1).to_not be_valid
    end
  end

  describe "from_user" do
    it "should not be valid without from_user" do
      @message1.to_user = nil
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

  describe "from_user" do
    it "should not be valid if from_user is the same as to_user" do
      @message1.to_user = @message1.from_user
      expect(@message1).to_not be_valid
    end
  end

end