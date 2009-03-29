class OzonBook < ActiveRecord::Base
  PARAMS = {
    "title" => "name",
    "publisher" => "publisher",
    "year" => "year",
    "isbn" => "isbn",
    "series" => "series",
    "str_authors" => "author",
    "annotation" => "description",
    "pages" => "page_extent"
  }
end
