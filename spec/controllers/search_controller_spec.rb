require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do
  describe "#create" do
    it "should return [] if nothing found" do
      book = mock_model Book
      Book.should_receive(:all).exactly(4).times.and_return([])

      post :create, :query => "aaa bbb"

      assigns[:books].should == []
    end
    
    it "should place books with more hits on first places" do
      book = mock_model Book
      Book.should_receive(:all).with(\
        :conditions => ["title LIKE ? OR orig_title LIKE ?", "%aaa%", "%aaa%"]).\
        and_return([:aaa_book, :aaa_bbb_book])
      Book.should_receive(:all).with(\
        :conditions => ["title LIKE ? OR orig_title LIKE ?", "%bbb%", "%bbb%"]).\
        and_return([:aaa_bbb_book])
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
        :conditions => ["title LIKE ? OR orig_title LIKE ?", "%aaa%", "%aaa%"]).\
        and_return([:title_book, :title_annot_book])
      Book.should_receive(:all).with(\
        :conditions => ["annotation LIKE ?", "%aaa%"]).\
        and_return([:annot_book, :title_annot_book])

      post :create, :query => "aaa"
  
      assigns[:books].should == [:title_annot_book, :title_book, :annot_book]
    end
     
    it "should return [] if query is empty" do
      book = mock_model Book
      Book.should_receive(:all).at_least(0).times.and_return []

      post :create, :query => nil
  
      assigns[:books].should == []
    end

  end
  

end
