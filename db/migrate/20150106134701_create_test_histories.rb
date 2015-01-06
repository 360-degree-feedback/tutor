class CreateTestHistories < ActiveRecord::Migration
  def change
    create_table :test_histories do |t|

      t.timestamps
    end
  end
end
