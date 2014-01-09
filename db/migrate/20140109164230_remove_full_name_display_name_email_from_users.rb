class RemoveFullNameDisplayNameEmailFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email, :string
    remove_column :users, :display_name, :string
    remove_column :users, :full_name, :string
  end
end
