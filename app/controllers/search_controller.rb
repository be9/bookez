class SearchController < ApplicationController
  include SearchHelper

  def show
  end
  
  def create
    @books = smart_search(params[:query],
                 :in_titles => true, :in_annotations => true, :in_authors => true)
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
end
