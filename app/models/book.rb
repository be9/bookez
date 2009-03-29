class Book < ActiveRecord::Base
  acts_as_commentable

  validates_presence_of :title

  validates_isbn :isbn, :allow_blank => true,
    :message => "имеет неверный формат"


  validates_numericality_of :year, :pages, :circulation, :only_integer => true, :greater_than => 0, :allow_nil => true

  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships, :order => :position
  
  has_many :ownerships, :dependent => :destroy
  has_many :users, :through => :ownerships

  has_many :rates

  def self.new_from_ozon(ozon_book)
    book = Book.new
    OzonBook::PARAMS.each do |bookez, ozon|
      val = ozon_book.send ozon
      book.send( "#{bookez}=", val ) if val
    end
    book
  end

  def rating
    rates.empty? ? (0.0) : (Rate.average :value, :conditions => {:book_id => id})
  end

  def rated_by_user?(user)
    return false unless user
    Rate.count( :conditions => {:book_id => id, :user_id => user.id} ) != 0
  end

  def str_authors
    if @str_authors
      @str_authors
    else
      authors.map {|x| x.name} .join ", "
    end
  end

  attr_writer :str_authors
  
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
