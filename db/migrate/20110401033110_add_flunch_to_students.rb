class AddFlunchToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :flunch, :boolean
    add_column :students, :fafter, :boolean
  end

  def self.down
    remove_column :students, :flunch
    remove_column :students, :fafter
  end
end
