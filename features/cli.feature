# SPDX-FileCopyrightText: Copyright (c) 2017-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT
Feature: Command Line Processing
  As an author of XML I want to be able to
  call XCOP as a command line tool

  Scenario: Help can be printed
    When I run bin/xcop with "-h"
    Then Exit code is zero
    And Stdout contains "--help"

  Scenario: Version can be printed
    When I run bin/xcop with "--version"
    Then Exit code is zero

  Scenario: Validating correct XML file
    Given I have a "test.xml" file with content:
    """
    <?xml version="1.0"?>
    <hello>Hello, world!</hello>

    """
    When I run bin/xcop with "test.xml"
    Then Stdout contains "test.xml looks good"
    And Exit code is zero

  Scenario: Validating incorrect XML file
    Given I have a "abc.xml" file with content:
    """
    <a><b>something</b>
    </a>
    """
    When I run bin/xcop with "abc.xml"
    Then Exit code is not zero

  Scenario: Fixing incorrect XML file
    Given I have a "broken.xml" file with content:
    """
    <a><b>something</b>
    </a>
    """
    When I run bin/xcop with "--fix broken.xml"
    Then Exit code is zero
    Then I run bin/xcop with "broken.xml"
    Then Exit code is zero
