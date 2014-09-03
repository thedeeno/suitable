Feature: Browser App
  As a suitor
  In order to woo my sweetheart
  I want an app to help me send charming messages

  Background:
    Given the suitor app is available
    Given I am a visitor

  Scenario: Sending a charm
    When I visit suitor
    And I enter a valid number
    And I click "Send Message"
    Then I should see "Swooned"
    And I should see the sms body

    Then I should see "Swooned"
    And I should see the sms body
