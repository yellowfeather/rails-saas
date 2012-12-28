Feature: Account security
  In order to securely access data
  As a user
  I want to access only my data

  Scenario: Unable to access another account
    Given two accounts
    When he signs in
    Then he is unable to access the other account
