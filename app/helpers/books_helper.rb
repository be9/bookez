module BooksHelper
  def format_authors(authors)
    authors.map do |author|
      link_to h(author.name), author
    end.join(', ')
  end

  def link_to_book(book)
    link_to h(book.title), book
  end
end
