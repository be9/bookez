require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AuthorsController do
  describe "GET 'show'" do
    it "should find author and his book, sorted by title" do
      b1 = mock_model Book, :title => "BBBB"
      b2 = mock_model Book, :title => "AAAA"
      b3 = mock_model Book, :title => "CCCC"
      author = mock_model Author, :books => [b1, b2, b3]
      Author.should_receive( :find ).with( "13" ).and_return author
      get 'show', :id => 13
      response.should be_success
      assigns[:author].should == author
      assigns[:books].should == [b2, b1, b3]
    end
  end
end
