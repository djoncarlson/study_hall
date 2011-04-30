class AddAllToAssignment < ActiveRecord::Migration
  def self.up
    add_column :assignments, :all, :string
  end

  def self.down
    remove_column :assignments, :all
  end
end
