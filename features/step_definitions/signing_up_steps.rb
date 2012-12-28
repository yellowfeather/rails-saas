module SigningUpSteps
  def SignUp(plan, account, email, password)
    visit '/users/sign_up?plan=' + plan
    fill_in 'Account', :with => account
    fill_in 'Email', :with => email
    fill_in 'user_password', :with => password
    fill_in 'user_password_confirmation', :with => password
    click_button 'Sign up'
  end
end

World(SigningUpSteps)

Given /^a new, unregistered user$/ do
end

When /^he signs up$/ do
  SignUp('silver', 'test', 'example@example.com', 'password')
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

