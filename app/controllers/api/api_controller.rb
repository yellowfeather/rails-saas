module Api
  class ApiController < RocketPants::Base
    include ActionController::Head
    include Doorkeeper::Helpers::Filter
    around_filter :scope_current_tenant
    DEFAULT_PAGE_SIZE = 200

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

    def paginated_collection(object, options = {})
      options = options.reverse_merge(:compact => true)
      meta = expose_metadata metadata_for(object, options, :paginated, false)
      { object.table_name => normalise_object(object, options) }.merge(meta) unless object.count == 0
    end
  end
end

