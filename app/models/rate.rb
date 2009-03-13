class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates_presence_of :user, :book, :value
  validates_numericality_of :value,
                            :only_integer => true
  validates_inclusion_of  :value,
                          :in => 1..10
  
  validate_on_create :uniqueness_of_user

  def uniqueness_of_user
    if user and book
      errors.add_to_base :message => "Вы уже оценили эту книгу." if
        Rate.count( :conditions => {:user_id => user.id, :book_id => book.id} ) != 0
    end
  end
end
