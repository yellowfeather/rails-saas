class Forms::Signup
  # ActiveModel plumbing to make `form_for` work
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  # Custom application code
  ATTRIBUTES = [:plan, :name, :subdomain, :email, :password, :password_confirmation]

  attr_accessor *ATTRIBUTES

  def initialize(attributes = {})
    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end
  end

  validate do
    [tenant, user].each do |object|
      unless object.valid?
        object.errors.each do |key, values|
          errors[key] = values
        end
      end
    end
  end

  def user
    @user ||= User.new(:email => email, :password => password, :password_confirmation => password_confirmation, :tenant_id => @tenant.id)
    @user.add_role(plan) unless @user.has_role? plan
    @user
  end

  def tenant
    @tenant ||= Tenant.new(:name => name, :subdomain => subdomain)
  end

  def save
    return false unless valid?
    if create_objects
      true
      #UserMailer.deliver_user_registered(user)
      #IpLogger.log(user, ip_address)
    else
      false
    end
  end

  private

  def create_objects
    ActiveRecord::Base.transaction do
      tenant.save!
      user.save!
    end
  rescue
    false
  end
end
