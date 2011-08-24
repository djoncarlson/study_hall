class AddCommentToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :comment, :string
  end

  def self.down
    remove_column :assignments, :comment
  end
end
