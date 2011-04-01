class AddTlunchToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :tlunch, :boolean
    add_column :students, :wlunch, :boolean
    add_column :students, :rlunch, :boolean
    add_column :students, :mafter, :boolean
    add_column :students, :tafter, :boolean
    add_column :students, :wafter, :boolean
    add_column :students, :rafter, :boolean
  end

  def self.down
    remove_column :students, :tlunch
    remove_column :students, :wlunch
    remove_column :students, :rlunch
    remove_column :students, :mafter
    remove_column :students, :tafter
    remove_column :students, :wafter
    remove_column :students, :rafter
  end
end
