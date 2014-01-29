Feature: Badge Robot

  Background:
    Given git remote is "https://github.com/doge/wow.git"

  Scenario: Generate default badges
    When I successfully run `badger badge /tmp/wow_repo`
    Then the output should contain:
    """
[![Build Status](http://img.shields.io/travis/doge/wow.svg)](https://travis-ci.org/doge/wow)
[![Coverage Status](http://img.shields.io/coveralls/doge/wow.svg)](https://coveralls.io/r/doge/wow)
[![Dependency Status](http://img.shields.io/gemnasium/doge/wow.svg)](https://gemnasium.com/doge/wow)
[![Code Climate](http://img.shields.io/codeclimate/github/doge/wow.svg)](https://codeclimate.com/github/doge/wow)
    """
    And the output should not contain:
    """
![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
    """
    And the output should not contain:
    """
[![Gem Version](http://img.shields.io/gem/v/suchgem.svg)](https://rubygems.org/gems/suchgem)
    """

  Scenario: Generate only a subset of badges
    When I successfully run `badger badge --not travis /tmp/wow_repo`
    Then the output should contain:
    """
[![Coverage Status](http://img.shields.io/coveralls/doge/wow.svg)](https://coveralls.io/r/doge/wow)
[![Dependency Status](http://img.shields.io/gemnasium/doge/wow.svg)](https://gemnasium.com/doge/wow)
[![Code Climate](http://img.shields.io/codeclimate/github/doge/wow.svg)](https://codeclimate.com/github/doge/wow)
    """
    And the output should not contain:
    """
[![Build Status](http://img.shields.io/travis/doge/wow.svg)](https://travis-ci.org/doge/wow)
    """

  Scenario: Generate a small subset of badges
     When I successfully run `badger badge --not coveralls,codeclimate /tmp/wow_repo`
     Then the output should contain:
     """
[![Build Status](http://img.shields.io/travis/doge/wow.svg)](https://travis-ci.org/doge/wow)
[![Dependency Status](http://img.shields.io/gemnasium/doge/wow.svg)](https://gemnasium.com/doge/wow)
     """
     And the output should not contain:
     """
[![Coverage Status](http://img.shields.io/coveralls/doge/wow.svg)](https://coveralls.io/r/doge/wow)
     """
     And the output should not contain:
     """
[![Code Climate](http://img.shields.io/codeclimate/github/doge/wow.svg)](https://codeclimate.com/github/doge/wow)
     """

   Scenario: Generate only certain badges
     When I successfully run `badger badge --only coveralls,codeclimate /tmp/wow_repo`
     Then the output should contain:
     """
[![Coverage Status](http://img.shields.io/coveralls/doge/wow.svg)](https://coveralls.io/r/doge/wow)
[![Code Climate](http://img.shields.io/codeclimate/github/doge/wow.svg)](https://codeclimate.com/github/doge/wow)
     """

   Scenario: Generate additional badges
     When I successfully run `badger badge --also mit /tmp/wow_repo`
     Then the output should contain:
     """
[![Build Status](http://img.shields.io/travis/doge/wow.svg)](https://travis-ci.org/doge/wow)
[![Coverage Status](http://img.shields.io/coveralls/doge/wow.svg)](https://coveralls.io/r/doge/wow)
[![Dependency Status](http://img.shields.io/gemnasium/doge/wow.svg)](https://gemnasium.com/doge/wow)
[![Code Climate](http://img.shields.io/codeclimate/github/doge/wow.svg)](https://codeclimate.com/github/doge/wow)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
     """

   @gemspec
   Scenario: Generate badges based on gemspec
     When I successfully run `badger badge /tmp/wow_repo`
     Then the output should contain:
     """
[![Build Status](http://img.shields.io/travis/doge/wow.svg)](https://travis-ci.org/doge/wow)
[![Coverage Status](http://img.shields.io/coveralls/doge/wow.svg)](https://coveralls.io/r/doge/wow)
[![Dependency Status](http://img.shields.io/gemnasium/doge/wow.svg)](https://gemnasium.com/doge/wow)
[![Code Climate](http://img.shields.io/codeclimate/github/doge/wow.svg)](https://codeclimate.com/github/doge/wow)
[![Gem Version](http://img.shields.io/gem/v/suchgem.svg)](https://rubygems.org/gems/suchgem)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
     """

   @gemspec
   Scenario: gemspec and --also mit
     Given I successfully run `badger badge --also mit /tmp/wow_repo`
     Then the output should not contain:
     """
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)
     """