class AddMlunchToStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :mlunch, :boolean
  end

  def self.down
    remove_column :students, :mlunch
  end
end
