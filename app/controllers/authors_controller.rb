class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @books = @author.books.sort_by { |book| book.title }

    #@books = @author.books.sort_by { |book| get_position_in_authors(@author, book) }
  end
end
