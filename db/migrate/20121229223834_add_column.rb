class AddColumn < ActiveRecord::Migration
  def up
    add_column :moves, :game_id, :integer
    add_index :moves, :game_id
  end

  def down
    remove_column :moves, :game_id
    remove_index :moves, :game_id
  end
end
