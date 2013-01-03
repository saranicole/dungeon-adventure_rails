class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :description
      t.string :entrance
      t.string :exit
      t.references :dungeon

      t.timestamps
    end
    add_index :rooms, :dungeon_id
  end
end
