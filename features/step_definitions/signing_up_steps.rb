module SigningUpSteps
  def SignUp(plan, name, subdomain, email, password)
    visit '/users/sign_up?plan=' + plan
    fill_in 'Company Name', :with => name
    fill_in 'URL', :with => subdomain
    fill_in 'Email', :with => email
    fill_in 'forms_signup_password', :with => password
    fill_in 'Password confirmation', :with => password
    click_button 'Sign up'
  end
end

World(SigningUpSteps)

When /^he signs up$/ do
  SignUp('silver', 'Test', 'test', 'example@example.com', 'password')
end

When /^he confirms the account$/ do
  unread_emails_for('example@example.com').size.should == 1

  open_last_email_for(last_email_address)

  click_email_link_matching /confirm/
end

Then /^he should receive an email with the subject "(.*)"$/ do |regexp|
  unread_emails_for('example@example.com').size.should == 1

  open_last_email_for(last_email_address)
  current_email.should have_subject(regexp)
end

