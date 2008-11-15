class SearchController < ApplicationController
  def show
  end
  
  def create
    query = (params[:query] || '').split
    books_rating = {} # book => rating
    query.each do |word|
      # find every word in title, orig_title and author
      Book.all(:conditions => ["title LIKE ? OR orig_title LIKE ?", "%#{word}%", "%#{word}%"]).each do |book|
        add_book_by_rating(books_rating, book, 2)
      end
      
      # find in annotation but with less rating
      Book.all(:conditions => ["annotation LIKE ?", "%#{word}%"]).each do |book|
        add_book_by_rating(books_rating, book, 1)
      end
      
      # find in authors
      Author.all(:conditions => ["name LIKE ?", "%#{word}%"]).each do |author|
        add_author_books(books_rating, author)
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
  def add_author_books(hash, author)
    author.get_books_with_position.each do |book, pos|
      add_book_by_rating( hash, book, 1 + 0.5**pos )
    end
  end

  def add_book_by_rating(hash, book, rating)
    hash[book] = (hash[book] || 0) + rating
  end
end
