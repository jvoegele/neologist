Feature: View Quips
  In order to receive wisdom
  As a user
  I want to view the quips of a particular person

  Scenario: View a user's quips
    Given there is a User
    And the User has posted the following quips:
      | quip |
      | Don't panic |
      | Time is an illusion. Lunchtime doubly so. |
      | Isn't it enough to see that a garden is beautiful without having to believe that there are fairies at the bottom of it too? |
    When I visit the User's page
    Then I should see the following quips:
      | quip |
      | Isn't it enough to see that a garden is beautiful without having to believe that there are fairies at the bottom of it too? |
      | Time is an illusion. Lunchtime doubly so. |
      | Don't panic |

  Scenario: View a user's latest quips
    Given there is a User
    And the user has posted more than "30" quips
    When I visit the User's page
    Then I should see the most recent "30" quips in reverse chronological order
