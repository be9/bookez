class AddOzonsIdToOzonBooks < ActiveRecord::Migration
  def self.up
    add_column :ozon_books, :ozon_id, :integer
  end

  def self.down
    remove_column :ozon_books, :ozon_id
  end
end
