class Author < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :authorships, :dependent => :destroy
  has_many :books, :through => :authorships

  def get_books_with_position
    # returns hash with book and
    # position of author in it's author list
    hash = {}
    authorships.each { |as| hash[as.book] = as.position }
    hash
  end
end
