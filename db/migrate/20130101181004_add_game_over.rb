class AddGameOver < ActiveRecord::Migration
  def up
    add_column :games, :over, :boolean
  end

  def down
    remove_column :games, :over
  end
end
