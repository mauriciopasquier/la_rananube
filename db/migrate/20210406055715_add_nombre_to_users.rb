class AddNombreToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nombre, :string, null: false
  end
end
