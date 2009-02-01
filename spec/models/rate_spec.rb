require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rate do
  before do
    [Book, User, Rate].each { |model| model.delete_all }
  end

  it "should create a new instance given valid attributes" do
    Factory.build(:rate).should be_valid
  end

  [:book, :user, :value].each do |field|
    it "should not be valid without #{field}" do
      Factory.build(:rate, field => nil).should_not be_valid
    end
  end

  it "should not be valid with non-integer value" do
    Factory.build(:rate, :value => 3.5).should_not be_valid
  end

  it "should not be valid with value more than 10" do
    Factory.build(:rate, :value => 11).should_not be_valid
  end

  it "should not be valid with value less than 1" do
    Factory.build(:rate, :value => 0).should_not be_valid
  end

  it "should not be valid if user already rated this book" do
    user = Factory.build :user
    book = Factory.build :book
    Factory.build(:rate, :user => user, :book => book).save
    Factory.build(:rate, :user => user, :book => book).should_not be_valid
  end

  it "should be valid if user already rated another book" do
    user = Factory.build :user
    book = Factory.build :book, :title => "1"
    another_book = Factory.build :book, :title => "2"
    Factory.build(:rate, :user => user, :book => book).save
    Factory.build(:rate, :user => user, :book => another_book).should be_valid
  end

  it "should be valid if another_user already rated this book" do
    user = Factory.build :user
    another_user = Factory.build :user
    book = Factory.build :book
    Factory.build(:rate, :user => another_user, :book => book).save
    Factory.build(:rate, :user => user, :book => book).should be_valid
  end
  
end
