module SigningInSteps
  def SignIn(email, password)
    visit '/users/sign_in'
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Sign in'
  end
end

World(SigningInSteps)

Given /^a registered user$/ do
  @tenant = Tenant.create!(:name => 'Test', :subdomain => 'test')
  @user = User.new(:email => 'test@example.com', :password => 'password', :tenant_id => @tenant.id)
  @user.skip_confirmation!
  @user.save!
end

When /^he signs in$/ do
  SignIn(@user.email, @user.password)
end

Then /^he should see "(.*?)"$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath('//*', :text => regexp)
  end
end

