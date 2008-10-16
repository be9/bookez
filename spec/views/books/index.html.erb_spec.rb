require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/books/index.html.erb" do
  include BooksHelper
  
  before(:each) do
    assigns[:books] = [
      stub_model(Book,
        :title => "value for title",
        :publisher => "value for publisher",
        :year => "1",
        :isbn => "value for isbn",
        :pages => "1",
        :orig_title => "value for orig_title",
        :annotation => "value for annotation",
        :circulation => "1",
        :series => "value for series"
      ),
      stub_model(Book,
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
    ]
  end

  it "should render list of books" do
    pending
    render "/books/index.html.erb"
    response.should have_tag("tr>td", "value for title", 2)
    response.should have_tag("tr>td", "value for publisher", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for isbn", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for orig_title", 2)
    response.should have_tag("tr>td", "value for annotation", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for series", 2)
  end
end

