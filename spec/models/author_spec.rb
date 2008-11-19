require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Author do
  before :each do
    [Author, Book, Authorship, User].each { |model| model.delete_all }
    
    @user = Factory :user
  end

  it "should create a new instance given valid attributes" do
    Factory.build(:author).should be_valid
  end

  it "#get_books_with_positon should return [book - pos] array" do
    a1 = Factory :author
    a2 = Factory :author
    a3 = Factory :author

    b1 = Factory :book, :title => "BookOne",   :authors => [a1,a3], :users => [@user]
    b2 = Factory :book, :title => "BookTwo",   :authors => [a2,a1], :users => [@user]
    b3 = Factory :book, :title => "BookThree", :authors => [a3,a1,a2], :users => [@user]

    a1.get_books_with_position.should == [ [b1, 1], [b2, 2], [b3, 2] ]
    a2.get_books_with_position.should == [ [b2, 1], [b3, 3] ]
    a3.get_books_with_position.should == [ [b1, 2], [b3, 1] ]
  end
end
