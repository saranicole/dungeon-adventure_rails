class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player
      t.references :dungeon

      t.timestamps
    end
    add_index :games, :dungeon_id
  end
end
