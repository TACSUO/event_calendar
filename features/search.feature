# :name, :event_type, :location, :description
Feature: Search

  Scenario Outline: search for an event by name, location, type and/or description
    Given I am on the events page
    When I fill in "q" with "<query>"
    And I press "go"
    Then I should be on the search events page
    And I should see "<year>"
    And I should see "<month>"
    And I should see "<name>"
    
    Examples:
      |query|year|month|name|
      |link event|2011|February|Linkable Event|
      |eugene|2010|October|Editable Event|
      |meet|2011|February|Restorable Event|
      |drinks|2011|February|Linkable Event|