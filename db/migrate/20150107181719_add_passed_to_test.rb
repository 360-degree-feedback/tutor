class AddPassedToTest < ActiveRecord::Migration
  def change
    add_column :tests, :passed, :boolean
  end
end
