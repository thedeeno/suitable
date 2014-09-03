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

  Scenario: Error, an invalid number
    When I visit suitor
    And I enter an invalid number
    And I click "Send Message"
    Then I should see "O Noes!"
    Then I should see "Invalid Phone Number"

  Scenario: Error, unrouteable number
    When I visit suitor
    And I enter a unrouteable number
    And I click "Send Message"
    Then I should see "O Noes!"
    Then I should see "Error sending text message"

