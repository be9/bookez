require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do
  describe "#create" do
    it "should return [] if nothing found" do
      book = mock_model Book
      Book.should_receive(:all).any_number_of_times.times.and_return([])

      author = mock_model Author
      Author.should_receive(:all).any_number_of_times.and_return([])

      post :create, :query => "aaa bbb"

      assigns[:books].should == []
    end
    
    it "should place books with more hits on first places" do
      book = mock_model Book
      Book.should_receive(:all).with(\
        :conditions => ["title LIKE ?", "%aaa%"]).\
        and_return([:aaa_book])
      Book.should_receive(:all).with(\
        :conditions => ["orig_title LIKE ?", "%aaa%"]).\
        and_return([:aaa_bbb_book])
      Book.should_receive(:all).with(\
        :conditions => ["title LIKE ?", "%bbb%"]).\
        and_return([:aaa_bbb_book])
      Book.should_receive(:all).with(\
        :conditions => ["orig_title LIKE ?", "%bbb%"]).\
        and_return([])
      ["aaa", "bbb"].each do |name|
        Book.should_receive(:all).with(\
          :conditions => ["annotation LIKE ?", "%#{name}%"]).\
          and_return([])
      end

      post :create, :query => "aaa bbb"
  
      assigns[:books].should == [:aaa_bbb_book, :aaa_book]
    end
    
    it "should place books with more hits in titles before books with hits in annotation" do
      book = mock_model Book
      Book.should_receive(:all).with(\
        :conditions => ["title LIKE ?", "%aaa%"]).\
        and_return([:title_annot_book])
      Book.should_receive(:all).with(\
        :conditions => ["orig_title LIKE ?", "%aaa%"]).\
        and_return([:title_book])
      Book.should_receive(:all).with(\
        :conditions => ["annotation LIKE ?", "%aaa%"]).\
        and_return([:annot_book, :title_annot_book])

      post :create, :query => "aaa"
  
      assigns[:books].should == [:title_annot_book, :title_book, :annot_book]
    end
     
    it "should return [] if query is empty" do
      book = mock_model Book
      Book.should_receive(:all).any_number_of_times.and_return []

      post :create, :query => nil
  
      assigns[:books].should == []
    end

    it "should find by authors and sort them by hits" do
      aaa_auth = mock Author
      aaa_auth.should_receive( :get_books_with_position ).with().\
        and_return( [ [:aaa_bbb, 1], [:aaa, 1] ])

      bbb_auth = mock Author
      bbb_auth.should_receive( :get_books_with_position ).with().\
        and_return( [ [:aaa_bbb, 2], ])

      author = mock_model Author
      Author.should_receive(:all).with(\
        :conditions => ["name LIKE ?", "%aaa%"]).\
        and_return([aaa_auth])
      Author.should_receive(:all).with(\
        :conditions => ["name LIKE ?", "%bbb%"]).\
        and_return([bbb_auth])

      book = mock_model Book
      Book.should_receive(:all).any_number_of_times.and_return []

      post :create, :query => "aaa bbb"

      assigns[:books].should == [:aaa_bbb, :aaa]
    end

    it "should find by authors and sort them by author position" do
      aaa_auth = mock Author
      aaa_auth.should_receive( :get_books_with_position ).with().\
        and_return( [ [:aaa_bbb, 1], [:aaa, 1] ])

      bbb_auth = mock Author
      bbb_auth.should_receive( :get_books_with_position ).with().\
        and_return( [ [:aaa_bbb, 2], [:bbb, 3] ])

      author = mock_model Author
      Author.should_receive(:all).with(\
        :conditions => ["name LIKE ?", "%aaa%"]).\
        and_return([aaa_auth])
      Author.should_receive(:all).with(\
        :conditions => ["name LIKE ?", "%bbb%"]).\
        and_return([bbb_auth])

      book = mock_model Book
      Book.should_receive(:all).any_number_of_times.and_return []

      post :create, :query => "aaa bbb"

      assigns[:books].should == [:aaa_bbb, :aaa, :bbb]
    end

    it "should place author-books before annotation-books while sorting" do
      aaa_auth = mock Author
      aaa_auth.should_receive( :get_books_with_position ).with().\
        and_return( [ [:author, 1], ] )

      author = mock_model Author
      Author.should_receive(:all).with(\
        :conditions => ["name LIKE ?", "%aaa%"]).\
        and_return([aaa_auth])

      book = mock_model Book
      Book.should_receive(:all).with(\
        :conditions => ["annotation LIKE ?", "%aaa%"]).\
        and_return([:annot])
      Book.should_receive(:all).any_number_of_times.and_return([])

      post :create, :query => "aaa"

      assigns[:books].should == [:author, :annot]
    end

  end
  

end
