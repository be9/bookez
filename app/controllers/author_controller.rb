class AuthorController < ApplicationController
  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

end
