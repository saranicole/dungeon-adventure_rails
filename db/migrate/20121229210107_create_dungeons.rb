class CreateDungeons < ActiveRecord::Migration
  def change
    create_table :dungeons do |t|
      t.string :name
      t.integer :numEnemies
      t.string :iorooms

      t.timestamps
    end
  end
end
