class Author < ActiveRecord::Base
  validates_presence_of :name
  
  has_many :authorships, :dependent => :destroy
  has_many :books, :through => :authorships
end
