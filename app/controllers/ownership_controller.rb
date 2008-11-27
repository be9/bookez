class OwnershipController < ApplicationController
  before_filter :find_book
  before_filter :login_required
  
  def create
    if current_user.books.include? @book
      flash[:notice] = "You already have this book in your library."
    else
      current_user.books << @book 
      flash[:notice] = "You succesfully added book to your library."
    end
    redirect_to @book
  end

  def destroy
    unless current_user.books.include? @book
      flash[:notice] = "You don't have this book in your library."
    else
      Ownership.find(:first, :conditions => "book_id = #{@book.id} AND user_id = #{current_user.id}").destroy
      flash[:notice] = "You succesfully deleted this book from your library."
    end
    redirect_to @book
  end

  private
  def find_book
    @book = Book.find( params[:book_id] )
  end

  def login_required
    unless current_user
      flash[:notice] = 'You should be logged in for working with books.'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
end
