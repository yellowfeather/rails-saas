Given /^two accounts$/ do
  @user = CreateRegisteredUser('Test1', 'test1', 'test1@example.com', 'password')
  @user2 = CreateRegisteredUser('Test2', 'test2', 'test2@example.com', 'password')
end

Then /^he is unable to access the other account$/ do
  visit 'http://test2.rails-saas.dev/products'
  page.should have_content("You need to sign in or sign up before continuing.")
end

