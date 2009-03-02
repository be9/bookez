class CreateOzonBooks < ActiveRecord::Migration
  def self.up
    create_table :ozon_books do |t|
      t.string :name
      t.string :author
      t.string :url
      t.integer :price
      t.string :currence
      t.string :picture
      t.string :publisher
      t.integer :year
      t.string :ISBN
      t.integer :page_extent
      t.string :binding
      t.text :description
      t.string :series
      t.string :delivery
      t.string :ordering

      t.timestamps
    end
  end

  def self.down
    drop_table :ozon_books
  end
end
