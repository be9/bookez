class CreateAuthorShips < ActiveRecord::Migration
  def self.up
    create_table :author_ships do |t|
      t.integer   :author_id
      t.integer   :book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :author_ships
  end
end
