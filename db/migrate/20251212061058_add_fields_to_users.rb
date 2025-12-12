class AddFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :integer
    add_column :users, :department, :string
    add_column :users, :name, :string
    add_column :users, :designation, :string
    add_column :users, :manager_id, :integer
  end
end
