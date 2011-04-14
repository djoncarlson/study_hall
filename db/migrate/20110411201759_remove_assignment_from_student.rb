class RemoveAssignmentFromStudent < ActiveRecord::Migration
  def self.up
    remove_column :students, :assignment
  end

  def self.down
    add_column :students, :assignment, :string
  end
end
