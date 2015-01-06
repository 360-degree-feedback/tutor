class AddNameSurnameAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :text
    add_column :users, :surname, :text
    add_column :users, :admin, :boolean
  end
end
