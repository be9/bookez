class RemovePositionFromAuthorsTable < ActiveRecord::Migration
  def self.up
    remove_column :authors, :position
  end

  def self.down
    add_column :authors, :position, :integer
  end
end
