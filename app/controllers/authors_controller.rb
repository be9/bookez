class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @books = @author.books.sort_by { |book| book.title }

    #@books = @author.books.sort_by { |book| get_position_in_authors(@author, book) }
  end

  private
  #def get_position_in_authors(author, book)
  #  Authorship.find(:first, :conditions => ["book_id=? AND author_id=?", "#{book.id}", "#{author.id}"]).position
  #end
end
