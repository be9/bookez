class Book < ActiveRecord::Base
  validates_presence_of :title

  validates_numericality_of :year, :pages, :circulation, :only_integer => true, :greater_than => 0, :allow_nil => true

  has_many :authorships
  has_many :authors, :through => :authorships
end
