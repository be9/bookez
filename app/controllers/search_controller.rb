class SearchController < ApplicationController
  def show
  end
  
  def create
    query = (params[:query] || '').split
    books_rating = {} # book => rating
    query.each do |word|
      # find every word in title, orig_title and author
      books = Book.all(:conditions => ["title LIKE ? OR orig_title LIKE ?", "%#{word}%", "%#{word}%"])
      add_books_by_rating(books_rating, books, 2)
      
      # find in annotation but with less rating
      books = Book.all(:conditions => ["annotation LIKE ?", "%#{word}%"])
      add_books_by_rating(books_rating, books, 1)
      
      # find in authors
      books = []
      authors = Author.all(:conditions => ["name LIKE ?", "%#{word}%"])
      authors.each do |author|
        books += author.books
        add_books_by_author_position(books_rating, books, author)
      end
    end
    # sort books by rating (descending)
    @books = (books_rating.sort_by { |x| -x[1] } ).map { |x| x[0] }
  end
 
  def by_title
    if true #xhr?
       render :text => "123\n456\nabcdef\nВася"
    else
       render :text => "XHR only", :status => 403
    end
  end
 
  private
  def add_books_by_author_position(books_rating_hash, books, author)
    books.each do |book|
      pos = Authorship.find(:first, :conditions => ["book_id=? AND author_id=?", "#{book.id}", "#{author.id}"]).position
      if books_rating_hash.include? book
        books_rating_hash[book] += 1+(0.5)**pos
      else
        books_rating_hash[book] = 1+(0.5)**pos
      end
    end
  end

  def add_books_by_rating(books_rating_hash, books, rating)
    books.each do |book|
      # 1.0 - rating for titles
      if books_rating_hash.include? book
        books_rating_hash[book] += rating
      else
        books_rating_hash[book] = rating
      end
    end
  end
end
