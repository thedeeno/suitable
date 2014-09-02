Feature: Browser App
  As a suitor
  In order to woo my sweetheart
  I want an app to help me send charming messages

  Background:
    Given the suitor app is available

  Scenario: Sending a charm
    Given a visitor "alice"

    When she visits the suitor index
    And she enters a valid phone number
    And she enters a valid subreddit
    And she submits the charm

    Then she should see "Charm sent"
    And she should see the generated charm
