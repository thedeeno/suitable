Feature: Command Line Interface
  As a power user
  In order to woo my sweetheart
  I want to use a cli to send charming messages

  Scenario: Sending a simple charm
    When I run suitor with "15005550001"
    Then the output includes "swooned with subreddit 'romance'"
    And the process exits 0

  Scenario: Specifying the subreddit
    When I run suitor with "15005550001 --subreddit doge"
    Then the output includes "swooned with subreddit 'doge'"
    And the process exits 0

  Scenario: Attempting invalid args
    When I run suitor with ""
    And the process exits 1
