class DropMapsTable < ActiveRecord::Migration
  def change
    drop_table :maps
  end
end
