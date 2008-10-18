class SearchController < ApplicationController
  def show
  end
  
  def create
    query = params[:query] || ''
    @books = Book.all(:conditions => ["title LIKE ?", "%#{query}%"])
  end
end
