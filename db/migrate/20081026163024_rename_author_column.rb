class RenameAuthorColumn < ActiveRecord::Migration
  def self.up
  rename_column :authors, :author, :name
  end

  def self.down
  rename_column :authors, :name, :author
  end
end
