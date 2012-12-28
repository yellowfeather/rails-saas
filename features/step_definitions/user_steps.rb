module UserSteps
  def CreateRegisteredUser(name, subdomain, email, password)
    @tenant = Tenant.create!(:name => name, :subdomain => subdomain)
    user = User.new(:email => email, :password => password, :tenant_id => @tenant.id)
    user.skip_confirmation!
    user.save!
    user
  end
end

World(UserSteps)
