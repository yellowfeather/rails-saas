class TenantApplicationController < ApplicationController
  around_filter :scope_current_tenant
  before_filter :authenticate_user!

  private

  def scope_current_tenant
    Tenant.current_id = current_tenant.id
    yield
  ensure
    Tenant.current_id = nil
  end
end

