class OwnershipController < ApplicationController
  before_filter :find_book
  
  def new
    if current_user
      if current_user.books.include? @book
        flash[:notice] = "You already have this book in your library."
      else
        current_user.books << @book 
        flash[:notice] = "You succesfully added book to your library."
      end
      redirect_to @book
    else
      flash[:notice] = 'You should be logged in for working with books.'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  def destroy
    if current_user
      unless current_user.books.include? @book
        flash[:notice] = "You don't have this book in your library."
      else
        @book.users.delete current_user
        flash[:notice] = "You succesfully deleted this book from your library."
      end
      redirect_to @book
    else
      flash[:notice] = 'You should be logged in for working with books.'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  private
  def find_book
    @book = Book.find( params[:book_id] )
  end
end
