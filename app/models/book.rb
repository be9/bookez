class Book < ActiveRecord::Base
  validates_presence_of :title

  validates_numericality_of :year, :pages, :circulation, :only_integer => true, :greater_than => 0, :allow_nil => true

  has_many :author_ships
  has_many :authors, :through => :author_ships
end
