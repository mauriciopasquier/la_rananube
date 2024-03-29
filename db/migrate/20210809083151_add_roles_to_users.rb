class AddRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :roles, :string, array: true, default: []

    add_index :users, :roles, using: 'gin'
  end
end
