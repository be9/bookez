require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OwnershipController do
  include AuthenticatedTestHelper

  before do
    [Book, User, Author, Authorship].each { |model| model.delete_all }
  end

  describe "#create" do
    it "should add new book to user and redirect to book" do
      user = Factory :user
      login_as user
      book = Factory :book

      post :create, :book_id => "#{book.id}"
      flash[:notice].should == "You succesfully added book to your library."
      response.should redirect_to(book_url(mock_book))
      user.books.include?( book ).should be_true
      book.users.include?( user ).should be_true
    end

    it "should not add repeated book to user and redirect to it"
    it "should not add book if user is not logged in"
  end

end
