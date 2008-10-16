require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/books/show.html.erb" do
  include BooksHelper
  
  before(:each) do
    assigns[:book] = @book = stub_model(Book,
      :title => "value for title",
      :publisher => "value for publisher",
      :year => "1",
      :isbn => "value for isbn",
      :pages => "1",
      :orig_title => "value for orig_title",
      :annotation => "value for annotation",
      :circulation => "1",
      :series => "value for series"
    )
  end

  it "should render attributes in <p>" do
    render "/books/show.html.erb"
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ publisher/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ isbn/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ orig_title/)
    response.should have_text(/value\ for\ annotation/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ series/)
  end
end

