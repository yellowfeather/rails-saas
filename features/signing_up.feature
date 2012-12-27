Feature: Signing up
  In order to use the site
  As a user
  I want to be able to sign up

  Scenario: Signing up
    Given a new, unregistered user
    When he signs up
    Then he should see "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."

