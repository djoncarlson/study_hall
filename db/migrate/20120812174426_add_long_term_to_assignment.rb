class AddLongTermToAssignment < ActiveRecord::Migration
  def self.up
     add_column :assignments, :long_term, :boolean, :default => false
     Assignment.update_all ["long_term = ?", false]
  end

  def self.down
    remove_column :assignments, :long_term
  end
end
