Feature: Manage event links

  Scenario: create a new link
    Given I am on the event page for "Editable Event"
    When I fill in "Name" with "Resource Alpha"
    And I fill in "URL" with "test.com"
    And I press "Create Link"
    Then I should see "Link successfully created."
    And I should be on the event page for "Editable Event"
    And I should see "Resource Alpha"
    And I should see "( http://test.com )"
  
  
  