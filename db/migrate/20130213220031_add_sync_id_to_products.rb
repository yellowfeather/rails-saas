class AddSyncIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sync_id, :uuid, null: false
  end
end
