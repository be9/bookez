class Book < ActiveRecord::Base
  validates_presence_of :title

  validates_presence_of :users

  validates_isbn :isbn, :allow_blank => true

  validates_numericality_of :year, :pages, :circulation, :only_integer => true, :greater_than => 0, :allow_nil => true

  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships, :order => :position
  
  has_many :ownerships, :dependent => :destroy
  has_many :users, :through => :ownerships

  def str_authors
    authors.map {|x| x.name} .join ", "
  end

  def str_authors=(au)
    @str_authors = au
  end
  
  before_save :parse_authors

  private

  def parse_authors
    if @str_authors
      authorships.delete_all
      self.authors = @str_authors.split( "," ).map do |x|
        Author.find_or_create_by_name( x.strip )
      end
    end
  end
end
