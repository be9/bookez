class SearchController < ApplicationController
  def show
  end
  
  def create
    query = (params[:query] || '').split
    books_rating = {} # book => rating
    query.each do |word|
      # find every word in title, orig_title and author
      books = Book.all(:conditions => ["title LIKE ?", "%#{word}%"])
      books |= Book.all(:conditions => ["orig_title LIKE ?", "%#{word}%"])
      add_books_by_rating(books_rating, books, 2)
      
      # find in annotation but with less rating
      books = Book.all(:conditions => ["annotation LIKE ?", "%#{word}%"])
      add_books_by_rating(books_rating, books, 1)
    end
    # sort books by rating
    @books = (books_rating.sort { |x, y| y[1] <=> x[1] } ).map { |x| x[0] }
  end
  
  private
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
