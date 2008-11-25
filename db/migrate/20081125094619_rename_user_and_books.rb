class RenameUserAndBooks < ActiveRecord::Migration
  def self.up
    rename_table :user_and_books, :ownerships
  end

  def self.down
    rename_table :ownerships, :user_and_books
  end
end
