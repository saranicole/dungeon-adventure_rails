class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.text :outcome
      t.references :room
      t.string :direction

      t.timestamps
    end
    add_index :moves, :room_id
  end
end
