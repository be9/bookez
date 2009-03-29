ActionController::Routing::Routes.draw do |map|
  map.resources :authors
  map.resource :search, :controller => 'search'
  map.resource :homepage

  map.book_rating "books/:id/rating", :controller => 'books', :action => 'rating'
  map.resources :books do |book|
    book.resources :ownerships, :controller => 'ownership'
    book.resources :comments, :controller => 'book_comments'
  end

  # Restful Authentication Resources  map.resources :passwords
  # Home Page
  map.root :controller => 'homepage', :action => 'show'

  map.resources :users
  map.signup  "signup", :controller => "users", :action => "new", :conditions => {:method => :get}
  map.connect "signup", :controller => "users", :action => "create", :conditions => {:method => :post}

  map.login   "login", :controller => "user_sessions", :action => "new", :conditions => {:method => :get}
  map.connect "login", :controller => "user_sessions", :action => "create", :conditions => {:method => :post}
  map.logout  "logout", :controller => "user_sessions", :action => "destroy"

  map.connect "search/:action", :controller => "search"

  map.root :controller => "user_sessions", :action => "new"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id' if ENV["RAILS_ENV"] == "test"
end
