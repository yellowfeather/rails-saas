class RegistrationsController < Devise::RegistrationsController
  def new
    @plan = params[:plan]
    if @plan
      super
    else
      redirect_to root_path, :notice => 'Please select a subscription plan below'
    end
  end

  private
  def build_resource(*args)
    if params[:account_name]
      tenant = Tenant.create(:name => params[:account_name], :subdomain => params[:account_name])
      tenant.save!
    end

    super

    if params[:plan]
      resource.add_role(params[:plan])
    end

    if tenant
      resource.tenant_id = tenant.id
    end
  end
end
