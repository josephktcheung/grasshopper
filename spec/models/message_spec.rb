require 'spec_helper'

describe Message do

  it "should not be valid without to_user"
  it "should be valid with to_user"
  it "should not be valid without from_user"
  it "should be valid with from_user"

  describe "from_user" do
    it "should not be the same as to_user"
  end

end