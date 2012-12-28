Feature: Signing in
  In order to use the site
  As a user
  I want to be able to sign in

  Scenario: Signing in via form
    Given a registered user
    When he signs in
    Then he should see "Signed in successfully."
    And he should be redirected to his account subdomain
