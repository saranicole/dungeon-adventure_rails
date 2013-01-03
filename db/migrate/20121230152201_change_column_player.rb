class ChangeColumnPlayer < ActiveRecord::Migration
  def up
    change_column(:games, :player, :integer)
    rename_column(:games, :player, :player_id)
    add_index(:games, :player_id)
  end

  def down
    change_column(:games, :player, :string)
    rename_column(:games, :player_id, :player)
    remove_index(:games, :player_id)
  end
end
