class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :questions, :lesson_id, :integer
    add_column :answers, :question_id, :integer
  end
end
