Feature: Post Quip
  In order to share my pithy thoughts with the world
  As a user
  I want to post a quip

  Background:
    Given that I am logged in

  Scenario: Post a basic valid quip
    When I post the quip "Hello world!"
    Then I should see the quip "Hello world!" on my page

  Scenario: Post a quip that is too long
    When I post the quip "This quip is too long. A quip can only be up to one hundred and forty characters long and this quip is longer than one hundred and forty characters."
    Then I should see a message indicating that the quip is too long

