class Product < ActiveRecord::Base
  include RocketPants::Cacheable
  resourcify
  attr_accessible :description, :name, :identifier, :quantity

  default_scope { where(tenant_id: Tenant.current_id) if Tenant.current_id }
end
