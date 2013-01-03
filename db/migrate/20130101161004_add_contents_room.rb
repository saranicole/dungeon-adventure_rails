class AddContentsRoom < ActiveRecord::Migration
  def up
    add_column :rooms, :contents, :text
  end

  def down
    remove_column :rooms, :contents
  end
end
