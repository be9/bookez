class Authorship < ActiveRecord::Base
  belongs_to :author
  belongs_to :book

  acts_as_list :scope => :book
end
