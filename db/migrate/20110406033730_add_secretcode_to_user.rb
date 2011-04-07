class AddSecretcodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :secretcode, :string
  end

  def self.down
    remove_column :users, :secretcode
  end
end
