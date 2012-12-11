class Tenant < ActiveRecord::Base
  attr_accessible :name, :subdomain
  validates_presence_of :subdomain
  validates_format_of :subdomain, with: /^[a-z0-9_]+$/, message: 'must be lowercase alphanumerics only'
  validates_length_of :subdomain, maximum: 32, message: 'exceeds maximum of 32 characters'
  validates_exclusion_of :subdomain, in: ['www', 'mail', 'ftp'], message: 'is not available'
  # Note: uniqueness will be caught at the db level

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end

  def self.current_id
    Thread.current[:tenant_id]
  end
end
