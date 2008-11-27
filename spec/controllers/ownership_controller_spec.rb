require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OwnershipController do
  include AuthenticatedTestHelper

  before do
    [Book, User, Ownership].each { |model| model.delete_all }
  end

  describe "#create" do
    it "should add new book to user and redirect to book" do
      owner = Factory :user
      book = Factory :book, :title => "smth", :users => [owner]

      user = Factory :user
      login_as user

      post :create, :book_id => "#{book.id}"

      flash[:notice].should == "You succesfully added book to your library."
      response.should redirect_to(book_url(book))
      user.books.should == [book]
      book.users.should == [owner, user] # TODO: it fails!
    end

    it "should not add repeated book to user and redirect to it" do
      owner = Factory :user
      book = Factory :book, :title => "smth", :users => [owner]

      login_as owner

      post :create, :book_id => "#{book.id}"

      flash[:notice].should == "You already have this book in your library."
      response.should redirect_to(book_url(book))
      owner.books.should == [book]
      book.users.should == [owner]
    end

    it "should not add book if user is not logged in" do
      owner = Factory :user
      book = Factory :book, :title => "smth", :users => [owner]

      post :create, :book_id => "#{book.id}"

      flash[:notice].should == "You should be logged in for working with books."
      owner.books.should == [book]
      book.users.should == [owner]
    end
  end

  describe "#destroy" do
    it "should delete book from user and redirect to book" do
      owner1 = Factory :user
      owner2 = Factory :user
      
      book = Factory :book, :title => "smth", :users => [owner1, owner2]
      login_as owner2

      delete :destroy, :book_id => "#{book.id}"

      flash[:notice].should == "You succesfully deleted this book from your library."
      response.should redirect_to(book_url(book))
      owner1.books.should == [book]
      owner2.books.should == []
      book.users.should == [owner1] # TODO: it fails! 
    end

    it "should not delete book from user if it is not in his library, then redirect to it" do
      owner = Factory :user
      book = Factory :book, :title => "smth", :users => [owner]

      login_as Factory :user

      delete :destroy, :book_id => "#{book.id}"

      flash[:notice].should == "You don't have this book in your library."
      response.should redirect_to(book_url(book))
      owner.books.should == [book]
      book.users.should == [owner]
    end

    it "should not delete book if user is not logged in" do
      owner = Factory :user
      book = Factory :book, :title => "smth", :users => [owner]

      delete :destroy, :book_id => "#{book.id}"

      flash[:notice].should == "You should be logged in for working with books."
      owner.books.should == [book]
      book.users.should == [owner]
    end
  end
end
