require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Book do
  before do
    [Book, User, Author, Authorship].each { |model| model.delete_all }

    @user = Factory :user
  end
  
  it "should create a new instance given valid attributes" do
    Factory.build(:book, :title => "NOT NIL!", :users => [@user]).should be_valid
  end

  it "should not be valid without title" do
    Factory.build(:book, :title => nil, :users => [@user]).should_not be_valid
  end
  
  it "should not be valid with blank title" do
    Factory.build(:book, :title => '  ', :users => [@user]).should_not be_valid
  end
  
  it "should not be valid without users" do
    Factory.build(:book, :users => []).should_not be_valid
  end
  
  [:publisher, :year, :isbn, :pages, :orig_title, :annotation, :circulation, :series, :info].each do |attr|
    it "should be valid with #{attr} blank" do
      Factory.build(:book, attr => nil, :title => "BBB", :users => [@user]).should be_valid
    end
  end

  [:year, :pages, :circulation].each do |attr|
    [0, "abc", -1].each do |y|
      it "should not be valid with #{attr} == '#{y}'" do
        Factory.build(:book, attr => y, :title => "BBBB", :users => [@user]).should_not be_valid
      end
    end    
  end 
  
  it "#str_authors should return a list of author names separated by comma and space" do
    authors = %w(Vasya Kolya Petya).map { |name| Factory :author, :name => name }

    @book = Factory :book, :title => "A TITLE", :users => [@user], :authors => authors
    @book.str_authors.should == "Vasya, Kolya, Petya"
  end
 
  it "#str_authors= should set authors through strings" do
    Factory :author, :name => "Knuth"

    lambda do
      @book = Factory :book, :title => "A TITLE", :users => [@user]

      @book.str_authors = " Bnuth ,  Knuth,Pruth"
      @book.save
    end.should change(Author, :count).from(1).to(3)

    @book.authors.map(&:name).join(' ').should == "Bnuth Knuth Pruth"
  end   
end
