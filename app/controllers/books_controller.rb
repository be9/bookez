class BooksController < ApplicationController
  # GET /books
  def index
    @books = Book.find(:all)
  end

  # GET /books/1
  def show
    @book = Book.find(params[:id])
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  def create
    params[:book][:authors] = params[:book][:authors].split( "," ).map do |x|
      Author.find_or_create_by_name( :name => x.strip )
    end
 
    @book = Book.new(params[:book])

    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to(@book)
    else
      render :action => "new"
    end
  end

  # PUT /books/1
  def update
    @book = Book.find(params[:id])

    if @book.update_attributes(params[:book])
      flash[:notice] = 'Book was successfully updated.'
      redirect_to(@book)
    else
      render :action => "edit"
    end
  end

  # DELETE /books/1
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to(books_url)
  end
end
