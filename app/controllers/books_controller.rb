class BooksController < ApplicationController
  include SearchHelper

  before_filter :find_book, :except => [:index, :new, :create]

  before_filter :require_user, :except => [:index, :show]

  # GET /books
  def index
    @books = Book.find :all
  end

  # GET /books/1
  def show
    @comment = Comment.new
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new params[:book]

    if params[:create_anyway] != "true"
      # search
      @similar_books = by_params( params[:book] )
      unless @similar_books.empty?
        flash[:notice] =  'Похожие книги были найдены в нашей библиотеке.'
        flash[:notice] << 'Может быть вы имели ввиду одну из них?'
        render :action => "new"
        return
      end
    end

    @book.users << current_user

    if @book.save
      flash[:notice] = 'Книги была успешно добавлена.'
      redirect_to book_url( @book )
    else
      render :action => "new"
    end
  end

  # PUT /books/1
  def update
    if @book.update_attributes(params[:book])
      flash[:notice] = 'Книга была успешно обновлена.'
      redirect_to book_url( @book )
    else
      render :action => "edit"
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy

    redirect_to books_url
  end

  # POST /books/1/rating
  def rating
    rate = Rate.find_or_initialize_by_book_id_and_user_id @book.id, current_user.id
    rate.value = params[:rate][:value]
    
    if rate.save
      flash[:notice] = "Ваша оценка учтена."
    else
      flash[:error] = "Извините, произошла ошибка, повторите оценку."
    end
    redirect_to book_url( @book )
  end

  private

  def require_user
    unless current_user
      flash[:notice] = 'Вы должны войти, чтобы получить доступ к этой странице.'
      redirect_to login_url
    end
  end

  def find_book
    @book = Book.find params[:id]
  end
end
