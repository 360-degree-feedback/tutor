class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title

      t.timestamps
    end
  end
end
