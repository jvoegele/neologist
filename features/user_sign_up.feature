Feature: User Sign Up
  In order to use the Neologist quip service
  As a potential user
  I want to sign up

  Scenario: Successful sign up
    Given I am on the sign up page
    And I am not logged in
    When I sign up with valid information
    Then I should be registered
    And I should see a confirmation message
    And I should be logged in

  @wip
  Scenario: Username already taken
    Given I am on the sign up page
    And I am not logged in
    When I sign up with a username that is already taken
    Then I should see a message indicating that the username is already in use
    And I should be returned to the sign up page

  @wip
  Scenario: Sign up with invalid information
    Given I am on the sign up page
    And I am not logged in
    When I sign up with invalid information
    Then I should see an error message
    And I should be returned to the sign up page
