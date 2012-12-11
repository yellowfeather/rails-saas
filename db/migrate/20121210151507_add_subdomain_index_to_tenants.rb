class AddSubdomainIndexToTenants < ActiveRecord::Migration
  def change
    add_index :tenants, :subdomain, :unique => true
  end
end
