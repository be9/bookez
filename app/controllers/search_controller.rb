require 'pp'
class SearchController < ApplicationController
  

  def index
    @book = Book.new
  end
  
  def create
    @books = []
    pp params[:book][:title]
    params[:book][:title].split.each do |word|
      pp "word >>#{word}<<"
      pp Book.find(word)
      pp "books >>#{@books}<<"
    end
  end
end
