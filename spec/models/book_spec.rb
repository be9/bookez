require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Book do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :publisher => "value for publisher",
      :year => "1",
      :isbn => "value for isbn",
      :pages => "1",
      :orig_title => "value for orig_title",
      :annotation => "value for annotation",
      :circulation => "1",
      :series => "value for series"
    }
  end

  it "should create a new instance given valid attributes" do
    Book.create!(@valid_attributes)
  end
end
