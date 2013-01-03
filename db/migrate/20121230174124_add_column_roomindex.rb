class AddColumnRoomindex < ActiveRecord::Migration
  def up
    add_column(:games,:roomindex,:integer)
  end

  def down
    remove_column(:games,:roomindex)
  end
end
