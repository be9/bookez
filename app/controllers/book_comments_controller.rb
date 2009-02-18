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
      flash[:notice] = 'Вы должны войти, чтобы оставлять комментарии.'
      redirect_to login_url
    end
  end
end
