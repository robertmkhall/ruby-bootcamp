Feature: Login
  Users must be logged in before they can view their bill

  Scenario: logging in with valid credentials
    Given I go to the 'Login' page
    When I log in with valid credentials
    Then I will be on the 'Bill' page

  Scenario: logging in with invalid credentials
    Given I go to the 'Login' page
    When I log in with invalid credentials
    Then I will be on the 'Login' page