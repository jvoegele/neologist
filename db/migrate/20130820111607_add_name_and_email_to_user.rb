class AddNameAndEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :email, :string

    add_index :users, :email
  end
end
