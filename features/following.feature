Feature: Following Users
  In order to keep abreast of other user's quips
  As a user
  I want to follow other users

  Background:
    Given that I am logged in
    And there is a User

  Scenario: Follow another user
    When I follow the User
    Then I should see the User on my following list

  Scenario: See who follows me
    When I am followed by the User
    Then I should see the User on my followers list
