require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BooksController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "books", :action => "index").should == "/books"
    end
  
    it "should map #new" do
      route_for(:controller => "books", :action => "new").should == "/books/new"
    end
  
    it "should map #show" do
      route_for(:controller => "books", :action => "show", :id => 1).should == "/books/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "books", :action => "edit", :id => 1).should == "/books/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "books", :action => "update", :id => 1).should == "/books/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "books", :action => "destroy", :id => 1).should == "/books/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/books").should == {:controller => "books", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/books/new").should == {:controller => "books", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/books").should == {:controller => "books", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/books/1").should == {:controller => "books", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/books/1/edit").should == {:controller => "books", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/books/1").should == {:controller => "books", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/books/1").should == {:controller => "books", :action => "destroy", :id => "1"}
    end
  end
end
