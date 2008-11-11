class BooksController < ApplicationController
  before_filter :find_book, :except => [:index, :new, :create]
  # GET /books
  def index
    @books = Book.find(:all)
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    if current_user
      @book = Book.new
    else
      flash[:notice] = 'You should be logged in for creating books.'
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = Book.new(params[:book])

    @book.users << current_user if current_user

    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to(@book)
    else
      render :action => "new"
    end
  end

  # PUT /books/1
  def update
    if @book.update_attributes(params[:book])
      flash[:notice] = 'Book was successfully updated.'
      redirect_to(@book)
    else
      render :action => "edit"
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy

    redirect_to(books_url)
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end
end
