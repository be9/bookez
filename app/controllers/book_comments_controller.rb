class BookCommentsController < ApplicationController
  def create
    book = Book.find( params[:book_id] )
    comment = book.comments.build( params[:comment] )
    comment.user = current_user
    comment.save
    redirect_to book_path(book)
  end

end
