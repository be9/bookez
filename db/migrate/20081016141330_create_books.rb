class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.string :publisher
      t.integer :year
      t.string :isbn
      t.integer :pages
      t.string :orig_title
      t.text :annotation
      t.integer :circulation
      t.string :series

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
