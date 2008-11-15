class Author < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :authorships, :dependent => :destroy
  has_many :books, :through => :authorships

  def get_books_with_position
    # returns array of pairs with book and
    # position of author in it's author list
    authorships.map do |as|
      [ as.book, as.position ]
    end
  end
end
