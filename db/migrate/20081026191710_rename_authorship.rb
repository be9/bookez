class RenameAuthorship < ActiveRecord::Migration
  def self.up
    rename_table :authorship, :authorships
  end

  def self.down
    rename_table :authorships, :authorship
  end
end
