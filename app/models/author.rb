class Author < ActiveRecord::Base
  validates_presence_of :author
  
  has_many :author_ships
  has_many :books, :through => :author_ships
end
