class AddIsbnIndexToOzonBooks < ActiveRecord::Migration
  def self.up
    add_index :ozon_books, :isbn
  end

  def self.down
    remove_index :ozon_books, :isbn
  end
end
