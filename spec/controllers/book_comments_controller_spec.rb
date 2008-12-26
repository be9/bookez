require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BookCommentsController do

  #Delete these examples and add some real ones
  it "should use BookCommentsController" do
    controller.should be_an_instance_of(BookCommentsController)
  end


  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end
end
