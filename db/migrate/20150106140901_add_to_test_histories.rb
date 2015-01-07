class AddToTestHistories < ActiveRecord::Migration
  def change
    add_column :test_histories, :test_id, :integer
    add_column :test_histories, :question_id, :integer
    add_column :test_histories, :answer_id, :integer
  end
end
