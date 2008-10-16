require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/books/new.html.erb" do
  include BooksHelper
  
  before(:each) do
    assigns[:book] = stub_model(Book,
      :new_record? => true,
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

  it "should render new form" do
    render "/books/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", books_path) do
      with_tag("input#book_title[name=?]", "book[title]")
      with_tag("input#book_publisher[name=?]", "book[publisher]")
      with_tag("input#book_year[name=?]", "book[year]")
      with_tag("input#book_isbn[name=?]", "book[isbn]")
      with_tag("input#book_pages[name=?]", "book[pages]")
      with_tag("input#book_orig_title[name=?]", "book[orig_title]")
      with_tag("textarea#book_annotation[name=?]", "book[annotation]")
      with_tag("input#book_circulation[name=?]", "book[circulation]")
      with_tag("input#book_series[name=?]", "book[series]")
    end
  end
end


