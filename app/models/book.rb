class Book < ActiveRecord::Base
  validates_presence_of :title

  validates_isbn :isbn

  validates_numericality_of :year, :pages, :circulation, :only_integer => true, :greater_than => 0, :allow_nil => true

  has_many :authorships
  has_many :authors, :through => :authorships, :order => :position

  def str_authors
    authors.map {|x| x.name} .join ", "
  end

  def str_authors=(au)
    authorships.delete_all
    self.authors = au.split( "," ).map do |x|
      Author.find_or_create_by_name( x.strip )
    end
  end
end
