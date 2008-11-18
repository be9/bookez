require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Book do
  before do
    Book.delete_all
    #@user = User.create()   What is correct way to create users here?
  end

  it "should create a new instance given valid attributes" do
    Factory.build(:book, :title => "NOT NIL!").should be_valid
  end

  it "should not be valid without title" do
    Factory.build(:book, :title => nil).should_not be_valid
  end
  
  it "should not be valid with blank title" do
    Factory.build(:book, :title => '  ').should_not be_valid
  end
  
  #it "should not be valid without users" do
  #  Factory.build(:book, :users => nil).should_not be_valid
  #end
  
  [:publisher, :year, :isbn, :pages, :orig_title, :annotation, :circulation, :series, :info].each do |attr|
    it "should be valid with #{attr} blank" do
      Factory.build(:book, attr => nil, :title => "BBB").should be_valid
    end
  end

  [:year, :pages, :circulation].each do |attr|
    [0, "abc", -1].each do |y|
      it "should not be valid with #{attr} == '#{y}'" do
        Factory.build(:book, attr => y, :title => "BBBB").should_not be_valid
      end
    end    
  end 
      
  it "should set authors through strings" do
    auth_mock = mock_model Author
    auth_mock.should_receive(:find_or_create_by_name).exactly(3).times.with(:string).and_return( nil )
    
    Book.stub!( :authorships ).and_return []

    book_mock = mock_model Book
    book_mock.should_receive( :authors= ).once.with( ["11", "22", "33"] )
    
    Factory.build(:book, :title => "New book", :str_authors => "11,\t 22,33").should be_valid
  end   
end
