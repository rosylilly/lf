Feature: Filters
  Scenario: Label filter
    When I run `lf label:tag1` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should contain "tag1"
    Then the output should not contain "tag2"

  Scenario: Ignore filter
    When I run `lf ignore:tag2` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should contain "tag1"
    Then the output should not contain "tag2"

  Scenario: Chain filter
    When I run `lf label:tag1,tag3 ignore:tag3` interactively
		And I type "tag1:hoge	tag2:fuga	tag3:piyo"
    And I close the stdin stream
    Then the output should contain "tag1"
    Then the output should not contain "tag2"
    Then the output should not contain "tag3"
