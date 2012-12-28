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
  @user = CreateRegisteredUser('Test', 'test', 'example@example.com', 'password')
end

When /^he signs in$/ do
  SignIn(@user.email, @user.password)
end

When /^he confirms the account $/ do
  unread_emails_for(current_email_address).size.should == 1

  # this call will store the email and you can access it with current_email
  open_last_email_for(last_email_address)
  current_email.should have_subject(/Account confirmation/)

  click_email_link_matching /confirm/
  page.should have_content("Confirm your new account")
end

Then /^he should see "(.*?)"$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath('//*', :text => regexp)
  end
end

