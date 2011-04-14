class AddActiveToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :active, :boolean
    add_column :assignments, :mlunch, :boolean
    add_column :assignments, :tlunch, :boolean
    add_column :assignments, :wlunch, :boolean
    add_column :assignments, :rlunch, :boolean
    add_column :assignments, :flunch, :boolean
    add_column :assignments, :mafter, :boolean
    add_column :assignments, :tafter, :boolean
    add_column :assignments, :wafter, :boolean
    add_column :assignments, :rafter, :boolean
    add_column :assignments, :fafter, :boolean
  end

  def self.down
    remove_column :assignments, :active
    remove_column :assignments, :mlunch
    remove_column :assignments, :tlunch
    remove_column :assignments, :wlunch
    remove_column :assignments, :rlunch
    remove_column :assignments, :flunch
    remove_column :assignments, :mafter
    remove_column :assignments, :tafter
    remove_column :assignments, :wafter
    remove_column :assignments, :rafter
    remove_column :assignments, :fafter
  end
end
