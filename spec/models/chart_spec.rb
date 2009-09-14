require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Chart do
  before(:each) do
    @valid_attributes = {
      :string => ,
      :year => 1,
      :week => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Chart.create!(@valid_attributes)
  end
end
