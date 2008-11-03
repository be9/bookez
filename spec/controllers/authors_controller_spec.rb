require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AuthorsController do

  #Delete these examples and add some real ones
  it "should use AuthorsController" do
    controller.should be_an_instance_of(AuthorsController)
  end


  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
