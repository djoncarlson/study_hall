class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :name
      t.text :assignment
      t.text :instructions
      t.integer :user_id

      t.timestamps
    end
    add_index :students, :user_id
  end

  def self.down
    drop_table :students
  end
end
