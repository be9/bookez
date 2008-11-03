require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AuthorController do

  #Delete these examples and add some real ones
  it "should use AuthorController" do
    controller.should be_an_instance_of(AuthorController)
  end


  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
