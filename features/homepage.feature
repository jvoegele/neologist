Feature: Homepage

  Scenario: Visit homepage not logged in
    Given that I am not logged in
    When I visit the homepage
    Then I should be shown a login form

  Scenario: Visit homepage logged in
    Given that I am logged in
    When I visit the homepage
    Then I should be shown my timeline
