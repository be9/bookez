class RenameAuthorShips < ActiveRecord::Migration
  def self.up
  rename_table :author_ships, :authorship
  end

  def self.down
    rename_table :authorship, :author_ships
  end
end
