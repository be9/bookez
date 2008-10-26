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
    # TODO
    # maybe Rails can do it faster???

    p = params[:book]
    author_names = p[:authors].split( "," ).map {|x| x.strip}

    authors = []
    author_names.each do |author|
      authors << Author.new( :name => author )
    end
    p[:authors] = [] # else we got error :(
    @book = Book.new(p)

    success = false
    if @book.save and authors.map { |x| x.save } .all?
      success = true
      authors.each do |author|
        succes &= Authorship.new( :book => @book, :author => author).save
      end
    end

    if success
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
