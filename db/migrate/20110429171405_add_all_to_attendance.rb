class AddAllToAttendance < ActiveRecord::Migration
  def self.up
    add_column :attendances, :all, :string
  end

  def self.down
    remove_column :attendances, :all
  end
end
