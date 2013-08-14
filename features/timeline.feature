Feature: Timeline
  In order to see what all of my followed users have to say
  As a user
  I want to view a timeline of quips

  Scenario: View timeline
    Given that I am logged in
    And I am following some users
    And the users have posted some quips
    When I view my timeline
    Then I should see up to "30" quips from my followed users
    And the quips should be displayed in reverse chronological order
