class AddUseridToAttendance < ActiveRecord::Migration
  def self.up
    add_column :attendances, :user_id, :integer
    add_index :attendances, :user_id
  end

  def self.down
    remove_column :attendances, :user_id
  end
end
