class AddItemsPlayer < ActiveRecord::Migration
  def up
    add_column :players, :items, :text
  end

  def down
    remove_column :players, :items
  end
end
