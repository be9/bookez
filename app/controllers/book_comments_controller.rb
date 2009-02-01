class BookCommentsController < ApplicationController
  before_filter :require_user

  def create
    book = Book.find( params[:book_id] )
    comment = book.comments.build( params[:comment] )
    comment.user = current_user
    comment.save
    redirect_to book_path(book)
  end

  private

  def require_user
    unless current_user
      flash[:notice] = 'You should be logged in for leaving comments.'
      redirect_to new_session_url
    end
  end
end
