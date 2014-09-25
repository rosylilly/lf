Feature: Run lf command
  Scenario: Running lf command
    When I run `lf` interactively
    And I close the stdin stream
    Then the exit status should be 0

  Scenario: Parsing ltsv
    When I run `lf` interactively
		And I type "tag1:hoge	tag2:fuga"
		And I type "tag:nginx	status:200"
		And I close the stdin stream
    Then the output should contain "tag1:hoge"
    Then the output should contain "tag:nginx"
