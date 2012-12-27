Feature: Signing in
  In order to use the site
  As a user
  I want to be able to sign in

  #Scenario: Signing in via confirmation
    #Given there are the following users:
      #| email               | password | unconfirmed |
      #| user@rails-saas.com | password | true        |
    #And "user@rails-saas.com" opens the email with subject "Confirmation instructions"
    #And they click on the first link in the email
    #Then I should see "Your account was successfully confirmed"
    #Then I should see "Signed in as user@rails-saas.com"

  Scenario: Signing in via form
    Given a registered user
    When he signs in
    Then he should see "Signed in successfully."
