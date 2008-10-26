require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Author do
  before(:each) do
    @valid_attributes = {
      :name => "Cool writer"
    }
  end

  it "should create a new instance given valid attributes" do
    Author.create!(@valid_attributes)
  end
end
