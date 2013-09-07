class AddDetentionToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :detention, :boolean, :default => false
    Assignment.update_all ["detention = ?", false]
  end
end
