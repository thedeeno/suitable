Feature: Browser App
  As a suitor
  In order to woo my sweetheart
  I want an app to help me send charming messages

  Background:
    Given the suitor app is available

  Scenario: Sending a charm
    Given I am a visitor

    When I visit the suitor index
    And I enter a valid phone number
    And I enter a valid subreddit
    And I submit the charm

    Then I should see "Charm sent"
    And I should see the sms body
