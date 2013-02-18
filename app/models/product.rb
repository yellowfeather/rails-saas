class Product < ActiveRecord::Base
  include RocketPants::Cacheable
  include Extensions::Syncable
  resourcify
  attr_accessible :description, :identifier, :name, :quantity, :sync_id

  default_scope { where(tenant_id: Tenant.current_id) if Tenant.current_id }
end
