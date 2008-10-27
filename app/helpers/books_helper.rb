module BooksHelper
  def authors_to_s(book)
    book.authors.map {|x| x.name} .join ", "
  end
end
