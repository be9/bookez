class CreateUserAndBooks < ActiveRecord::Migration
 
  # needed to prevent errors
  # ( it would be renamed in Ownersip )
  class UserAndBooks < ActiveRecord::Base; end

  def self.up
    create_table :user_and_books do |t|
      t.integer   :user_id
      t.integer   :book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_and_books
  end
end
