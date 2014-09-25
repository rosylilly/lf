Feature: Run lf command
  Scenario: Running lf command
    When I run `lf` interactively
    And I close the stdin stream
    Then the exit status should be 0

  Scenario: Show version
    When I run `lf -v`
    Then the exit status should not be 0
    Then the output should contain "lf"

  Scenario: Show help
    When I run `lf -h`
    Then the exit status should not be 0
    Then the output should contain "Usage: lf"

  Scenario: Show error on the unknown option
    When I run `lf --unknown`
    Then the exit status should not be 0

  Scenario: Parsing ltsv
    When I run `lf` interactively
		And I type "tag1:hoge	tag2:fuga"
		And I type "tag:nginx	status:200"
		And I close the stdin stream
    Then the output should contain "tag1:hoge"
    Then the output should contain "tag:nginx"

  Scenario: Parsing ltsv file
    Given a file named "test.ltsv" with:
      """
      tag:ayataka message:選ばれたのは綾鷹でした
      """
    When I run `lf test.ltsv`
    Then the output should contain "tag:ayataka"
