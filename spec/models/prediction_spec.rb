require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Prediction do
  before(:each) do
    @valid_attributes = {
      :user_id => User.find_or_create_by_username('foo'),
      :guess => "value for guess",
      :year => 1,
      :week => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Prediction.create!(@valid_attributes)
  end
end
