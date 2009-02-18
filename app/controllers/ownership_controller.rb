class OwnershipController < ApplicationController
  before_filter :find_book
  before_filter :require_user
  
  def create
    if current_user.books.include? @book
      flash[:notice] = "Эта книга уже есть в вашей библиотеке"
    else
      current_user.books << @book 
      flash[:notice] = "Вы успешно добавили книгу в свою библиотеку"
    end
    redirect_to @book
  end

  def destroy
    unless current_user.books.include? @book
      flash[:notice] = "У вас нет такой книги"
    else
      Ownership.find(:first, :conditions => "book_id = #{@book.id} AND user_id = #{current_user.id}").destroy
      flash[:notice] = "Книга удалена из вашей библиотеки"
    end
    redirect_to @book
  end

  private
  def find_book
    @book = Book.find( params[:book_id] )
  end

  def require_user
    unless current_user
      flash[:notice] = 'Вы должны войти, чтобы получить доступ к этой странице.'
      redirect_to login_url
    end
  end
end
