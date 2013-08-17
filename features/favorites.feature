Feature: Favorite Quips
  In order to remember my most favorite quips
  As a user
  I want to mark quips as favorites and be able to view my list of favorite quips

  Background:
    Given that I am logged in

  Scenario: View favorite quips
    Given I have marked some quips as favorites
    When I visit my favorite quips page
    Then I should see all of my favorite quips
    And the quips should be displayed in reverse chronological order

  Scenario: Mark a quip as a favorite
    Given there is a User
    And the User has posted some quips
    When I visit the User's page
    And I mark one of the quips as a favorite
    Then I should see the quip in my list of favorites

