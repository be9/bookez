class SearchController < ApplicationController
  include SearchHelper

  def show
  end
  
  def create
    @books = smart_search(params[:query],
                 :in_titles => true, :in_annotations => true, :in_authors => true)
  end
 
  def by_title
    if request.xhr?
      params[:limit] ||= 30
      render :text => (search_book(:title, params[:q]))[0, params[:limit].to_i].map( &:title ).join("\n")
    else
      render :text => "XHR only", :status => 403
    end
  end
  
  def by_author
    if request.xhr?
      q = params[:q]
      author = q.split(",").last.lstrip
      static = q[0, q.length - author.length] # cut off author
      params[:limit] ||= 30

      render :text => search_author( author.strip )[0, params[:limit].to_i].map { |x| "#{static}#{x.name}" }.join("\n")
    else
      render :text => "XHR only", :status => 403
    end
  end



  def by_isbn_local
    by_isbn Book
  end

  def by_isbn_ozon
    by_isbn OzonBook
  end

  private
  def by_isbn(model)
    if request.xhr?
      books = model.find :all, :conditions => ["isbn like ?", params[:q] + "%"]

      render :text => books.map { |b| b.title }.join( "\n" )
    else
      render :text => "XHR only", :status => 403
    end
  end
end
