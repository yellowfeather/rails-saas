class ApplicationController < ActionController::Base
  protect_from_forgery

  def valid_subdomain
    request.subdomain.present? && request.subdomain != 'www'
  end

  def current_tenant
    Tenant.find_by_subdomain! request.subdomain
  end

  def after_sign_in_path_for(user)
    tenant = Tenant.find(user.tenant_id)
    'http://' + tenant.subdomain + '.rails-multitenant.dev'
  end

  helper_method :current_tenant
end
