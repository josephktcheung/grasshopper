require 'spec_helper'

describe User do

	it "is valid with an email"

  it "is invalid without an email"

  describe "password is provided" do
    it "should be valid with password_confirmation"

    context "password_confirmation is provided as empty" do
      it "should be invalid without password_confirmation"
    end

    context "password_confirmation is provided as nil" do
      it "should be valid without password_confirmation"
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
      it "authenticate correctly"
    end
  end

  describe "reset password" do
    context "password is blank" do
      it "should be invalid if password is blank"
    end

    context "password is not blank" do
      context "password with confirmation matches" do
        it "should have the fish and salt changed"

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
      it "should have value in salt and fish"

      context "encrypted password is not the same as plain" do
        it "should have values of password and fish differently"
      end
    end

    context "password is not present" do
      it "should not have value in salt and fish"
    end
  end
end