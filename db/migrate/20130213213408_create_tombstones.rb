class CreateTombstones < ActiveRecord::Migration
  def change
    create_table :tombstones do |t|
      t.string :klass, null: false
      t.uuid :sync_id, null: false

      t.timestamps
    end
  end
end
