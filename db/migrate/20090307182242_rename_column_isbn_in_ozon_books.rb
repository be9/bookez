class RenameColumnIsbnInOzonBooks < ActiveRecord::Migration
  def self.up
    rename_column :ozon_books, :ISBN, :isbn
  end

  def self.down
    rename_column :ozon_books, :isbn, :ISBN
  end
end
