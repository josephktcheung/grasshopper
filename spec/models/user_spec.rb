require 'spec_helper'

describe User do

  before :each do
    user = User.create(first_name: 'Grass', last_name: 'Hopper', email: 'gh@ga.co', password: '123', password_confirmation: '123', role: 'master')
  end

  describe "password is provided" do
    before :each do
      @user = User.new(email: 'gh@ga.co', password: '123', password_confirmation: '123')
    end

    it "should be valid with password_confirmation" do
      @user.save
      expect(@user).to be_valid
    end

    context "password_confirmation is provided as empty" do
      it "should be invalid without password_confirmation" do
        @user.password_confirmation = ''
        @user.save
        expect(@user).to have(1).errors_on(:password_confirmation)
      end
    end

    context "password_confirmation is provided as nil" do
      it "should be valid without password_confirmation" do
        @user.password_confirmation = nil
        @user.save
        expect(@user).to be_valid
      end
    end
  end

  describe "authenticate username and password" do
    describe "self.authenticate" do
      context "correct password" do
        it "should be valid to authenticate"
      end

      context "incorrect password" do
        it "should return nil to authenticate"
      end
    end

    describe "authenticate" do
      it "should authenticate correctly" do
        user = User.find_by email: 'gh@ga.co'
        auth_result = user.authenticate '123'
        result = user.fish == BCrypt::Engine.hash_secret('123', user.salt)
        expect(auth_result).to eq result
      end
    end
  end

  describe "reset password" do
    context "password is blank" do
      it "should be invalid if password is blank"
    end

    context "password is not blank" do
      context "password with confirmation matches" do
        it "should have the fish and salt changed" do #TODO: What does this have to do with the fish and salt fields? -Alex
          @user = User.find_by email: 'gh@ga.co'
          @user.set_password_reset
          expect(@user.code).to_not be_nil
          expect(@user.expires_at).to_not be_nil
        end

        it "should have code and expires_at set to nil"
      end

      context "password with confirmation not matches" do
        it "should have the fish and salt unchanged"

        it "should have code and expires_at unchanged"
      end
    end
  end

  describe "Set random password if password is not provided" do
    context "salt and fish exists" do
      it "should have value in salt and fish"
    end
  end

  describe "Password is encrypted before save" do
    context "password is present" do
      it "should have value in salt and fish" do
        @user = User.new email: 'gh@ga.co'
        @user.password = '123'
        @user.send(:encrypt_password)
        expect(@user.salt).to_not be_nil
        expect(@user.fish).to_not be_nil
      end

      context "encrypted password is not the same as plain" do
        it "should have values of password and fish differently"
      end
    end

    context "password is not present" do
      it "should not have value in salt and fish"
    end
  end

  # Our own user tests

  it "should be valid with a first name, last name, email, role, and status" do
    expect(user).to be_valid
  end

  it "should not be valid without a first name" do
    user.first_name = nil
    expect(user).to_not be_valid
  end
  it "should not be valid without a last name" do
    user.last_name = nil
    expect(user).to_not be_valid
  end
  it "should not be valid without an email" do
    user.email = nil
    expect(user).to_not be_valid
  end
  it "should not be valid without a role" do
    user.role = nil
    expect(user).to_not be_valid
  end
  it "should not be valid without is_active" do
    user.is_active = nil
    expect(user).to_not be_valid
  end

  describe "first name and last name" do
    it "should be a capital letter followed by lowercase letters" do
      expect(user.first_name).to match /[A-Z][a-z]*/
      expect(user.last_name).to match /[A-Z][a-z]*/
    end
  end

  describe "email" do
    it "should be a valid email format" do
      expect(user.email).to match /.*@.*\..*/
    end
  end

  describe "role" do
    it "should be either 'master' or 'apprentice'" do
      expect(user.role).to match /(master)|(apprentice)/
    end
  end

  describe "is_active" do
    it "should be true when user is saved" do
      expect(user.is_active).to eq true
    end
  end

end