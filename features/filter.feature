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

  Scenario: Quoted argv
    When I run `lf "label:tag1,tag3"` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should contain "tag1"
    Then the output should not contain "tag2"

  Scenario: Equal filter(match)
    When I run `lf eq:tag1:hoge` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should contain "tag1"
    Then the output should contain "tag2"

  Scenario: Equal filter(miss-match)
    When I run `lf eq:tag1:fuga` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should not contain "tag1"
    Then the output should not contain "tag2"

  Scenario: Regexp filter(match)
    When I run `lf reg:tag1:..ge` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should contain "tag1"
    Then the output should contain "tag2"

  Scenario: Regexp filter(miss-match)
    When I run `lf reg:tag1:^f` interactively
		And I type "tag1:hoge	tag2:fuga"
    And I close the stdin stream
    Then the output should not contain "tag1"
    Then the output should not contain "tag2"
