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

  it "#get_books_with_positon should return [book - pos] array" do
    author = Author.create(@valid_attributes)

    as = mock Authorship
    as.stub!(:book).and_return("11", "22", "33")
    as.stub!(:position).and_return(5, 6, 7)

    author.stub!(:authorships).and_return([ as, as, as ])

    author.get_books_with_position.should == [ ["11", 5],  ["22", 6], ["33", 7] ]
  end
end
