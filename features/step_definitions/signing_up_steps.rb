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
  SignUp('silver', 'test', 'test@example.com', 'password')
end

