Feature: Signing up
  In order to use the site
  As a user
  I want to be able to sign up

  Background:
    Given a clear email queue

  Scenario: Signing up
    Given a new, unregistered user
    When he signs up
    Then he should see "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    And he should receive an email with the subject "Confirmation instructions"

  Scenario: Signing in via confirmation
    Given a new, unregistered user
    When he signs up
    And he confirms the account
    Then he should see "Your account was successfully confirmed"

  Scenario: Cannot sign up with an existing subdaomin
    Given a registered user
    And a new, unregistered user
    When he signs up
    Then he should see "has already been taken"
