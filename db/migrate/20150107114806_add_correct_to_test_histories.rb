class AddCorrectToTestHistories < ActiveRecord::Migration
  def change
    add_column :test_histories, :correct, :boolean
  end
end
