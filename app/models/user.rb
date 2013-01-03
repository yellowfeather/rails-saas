class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :tenant_id
  #has_secure_password
  validates_uniqueness_of :email, scope: :tenant_id

  default_scope { where(tenant_id: Tenant.current_id) if Tenant.current_id }

  def self.authenticate!(username, password)
    return nil if username.blank? || password.blank?

    if (user = User.find_by_email(username))
      return user if user.valid_password?(password)
    end

    nil
  end

  def invite!(invited_by = nil)
    logger.info "User invite: " + Tenant.current_id.to_s
    self.tenant_id = Tenant.current_id
    super invited_by
  end

  def self.blacklist_keys
    @blacklist_keys ||= super - ["id"]
  end
end
