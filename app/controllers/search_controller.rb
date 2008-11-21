class SearchController < ApplicationController
  def show
  end
  
  def create
    query = (params[:query] || '').split
    books_rating = {} # book => rating
    query.each do |word|
      search_book(:title, word).each do |book|
        add_book_by_rating(books_rating, book, 2)
      end
      
      search_book(:orig_title, word).each do |book|
        add_book_by_rating(books_rating, book, 1.5)
      end
      
      search_book(:annotation, word).each do |book|
        add_book_by_rating(books_rating, book, 1)
      end
      
      # find in authors
      search_author(word).each do |author|
        add_author_books(books_rating, author, 1, 2)
      end
    end

    # sort books by rating (descending)
    @books = (books_rating.sort_by { |x| -x[1] } ).map { |x| x[0] }
  end
 
  def by_title
    if true #xhr?
      render :text => (search_book(:title, params[:q]) | search_book(:orig_title, params[:q]))[0, params[:limit].to_i].map( &:title ).join("\n")
    else
      render :text => "XHR only", :status => 403
    end
  end
  
  def by_author
    if true #xhr?
      q = params[:q]
      author = q.split(",").last
      static = q[0, q.length - author.length] # cut off author

      render :text => search_author( author.strip )[0, params[:limit].to_i].map { |x| "#{static}#{x.name}" }.join("\n")
    else
      render :text => "XHR only", :status => 403
    end
  end

  private
  def search_book(field, str)  
    # find str in book's field
    Book.all(:conditions => ["#{field} LIKE ?", "%#{str}%"])
  end

  def search_author(str)  
    # find author by name
    Author.all(:conditions => ["name LIKE ?", "%#{str}%"])
  end

  def add_author_books(hash, author, min_rating, max_rating)
    author.get_books_with_position.each do |book, pos|
      add_book_by_rating( hash, book,
        min_rating + (max_rating - min_rating) * 0.5**pos)
    end
  end

  def add_book_by_rating(hash, book, rating)
    hash[book] = (hash[book] || 0) + rating
  end
end
