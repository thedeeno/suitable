Feature: Command Line Interface
  As a power user
  In order to woo my sweetheart
  I want to use a cli to send charming messages

  Scenario: Sending a simple charm
    When I run suitor with "15005550006"
    Then the output includes "Swooned."
    Then the output includes "Message:"
    And the process exits 0

  Scenario: Specifying the subreddit
    When I run suitor with "--subreddit doge 15005550006"
    Then the output includes "Swooned."
    Then the output includes "Message:"
    And the process exits 0

  Scenario: Attempting invalid args
    When I run suitor with ""
    And the process exits 1
