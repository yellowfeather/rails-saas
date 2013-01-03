module Api
  class ApiController < RocketPants::Base
    include ActionController::Head
    include Doorkeeper::Helpers::Filter
    around_filter :scope_current_tenant

    private

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def current_tenant
      Tenant.find_by_subdomain! request.subdomain
    end

    def scope_current_tenant
      Tenant.current_id = current_tenant.id
      yield
    ensure
      Tenant.current_id = nil
    end
  end
end

