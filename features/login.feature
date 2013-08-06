Feature: Login

  Background:
    Given that I am on the login page

  Scenario: Successful login
    When I login with valid credentials
    Then I should be logged in

  Scenario: Unsuccessful login
    When I login with invalid credentials
    Then I should be returned to the login page
    And I should see an error message
