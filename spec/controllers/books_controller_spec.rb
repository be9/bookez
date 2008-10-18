require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BooksController do

  def mock_book(stubs={})
    @mock_book ||= mock_model(Book, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all books as @books" do
      Book.should_receive(:find).with(:all).and_return([mock_book])
      get :index
      assigns[:books].should == [mock_book]
    end

  end

  describe "responding to GET show" do

    it "should expose the requested book as @book" do
      Book.should_receive(:find).with("37").and_return(mock_book)
      get :show, :id => "37"
      assigns[:book].should equal(mock_book)
    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new book as @book" do
      Book.should_receive(:new).and_return(mock_book)
      get :new
      assigns[:book].should equal(mock_book)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested book as @book" do
      Book.should_receive(:find).with("37").and_return(mock_book)
      get :edit, :id => "37"
      assigns[:book].should equal(mock_book)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created book as @book" do
        Book.should_receive(:new).with({'these' => 'params'}).and_return(mock_book(:save => true))
        post :create, :book => {:these => 'params'}
        assigns(:book).should equal(mock_book)
      end

      it "should redirect to the created book" do
        Book.stub!(:new).and_return(mock_book(:save => true))
        post :create, :book => {}
        response.should redirect_to(book_url(mock_book))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved book as @book" do
        Book.stub!(:new).with({'these' => 'params'}).and_return(mock_book(:save => false))
        post :create, :book => {:these => 'params'}
        assigns(:book).should equal(mock_book)
      end

      it "should re-render the 'new' template" do
        Book.stub!(:new).and_return(mock_book(:save => false))
        post :create, :book => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested book" do
        Book.should_receive(:find).with("37").and_return(mock_book)
        mock_book.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :book => {:these => 'params'}
      end

      it "should expose the requested book as @book" do
        Book.stub!(:find).and_return(mock_book(:update_attributes => true))
        put :update, :id => "1"
        assigns(:book).should equal(mock_book)
      end

      it "should redirect to the book" do
        Book.stub!(:find).and_return(mock_book(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(book_url(mock_book))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested book" do
        Book.should_receive(:find).with("37").and_return(mock_book)
        mock_book.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :book => {:these => 'params'}
      end

      it "should expose the book as @book" do
        Book.stub!(:find).and_return(mock_book(:update_attributes => false))
        put :update, :id => "1"
        assigns(:book).should equal(mock_book)
      end

      it "should re-render the 'edit' template" do
        Book.stub!(:find).and_return(mock_book(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested book" do
      Book.should_receive(:find).with("37").and_return(mock_book)
      mock_book.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the books list" do
      Book.stub!(:find).and_return(mock_book(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(books_url)
    end

  end

end
