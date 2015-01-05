class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :title
      t.boolean :correct

      t.timestamps
    end
  end
end
