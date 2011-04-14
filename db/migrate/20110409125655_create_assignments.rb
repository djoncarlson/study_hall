class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.string :assn
      t.string :instructions
      t.integer :user_id
      t.integer :student_id

      t.timestamps
    end
    add_index :assignments, :user_id
    add_index :assignments, :student_id
  end

  def self.down
    drop_table :assignments
  end
end
