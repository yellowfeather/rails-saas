class AddTenantToProducts < ActiveRecord::Migration
  def change
    add_column :products, :tenant_id, :integer
    add_index :products, :tenant_id
  end
end
