class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :dungeons, :iorooms, :text
  end

  def down
    add_column :dungeons, :iorooms, :string
  end
end
