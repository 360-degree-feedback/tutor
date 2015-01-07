class AddColumnsToTests < ActiveRecord::Migration
  def change
    add_column :tests, :lesson_id, :integer
    add_column :tests, :user_id, :integer
    add_column :tests, :mark, :integer
    add_column :tests, :total, :integer
  end
end
