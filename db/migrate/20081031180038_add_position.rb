class AddPosition < ActiveRecord::Migration
  def self.up
    add_column :authorships, :position, :integer
  end

  def self.down
    remove_column :authorships, :position
  end
end
