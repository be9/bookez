class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    params[:comment][:user] = current_user
    book.add_comment( Comment.new(params[:comment]) )
    redirect_to book_path(book)
  end

end
