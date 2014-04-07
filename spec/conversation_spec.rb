require 'spec_helper'

describe Conversation do
  it "should not valid without created_by"
  it "should be valid with created_by"
  it "should not valid without created_for"
  it "should be valid with created_for"
  it "should not valid without created_at"
  it "should be valid with created_at"
  it "should not valid without updated_at"
  it "should be valid with updated_at"
  it "should update updated_at when new message is created"
end