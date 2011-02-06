Feature: Manage event links

  Scenario: create a new link
    Given I am on the event page for "Editable Event"
    When I fill in "Name" with "Resource Alpha"
    And I fill in "URL" with "test.com"
    And I press "Create Link"
    Then I should see "Link successfully created."
    And I should be on the event page for "Editable Event"
    And I should see "Resource Alpha"
    And I should see "http://test.com"
  
  Scenario: edit a link
    Given I am on the event page for "Editable Event"
    When I follow "edit" within "div.event > div.links > p:first-child"
    Then I should be on the edit link page for "Editable Event" "Editable Link"
    When I fill in "Name" with "Updated Link"
    And I fill in "URL" with "example.com"
    And I press "Update Link"
    Then I should see "Link successfully updated."
    And I should be on the event page for "Editable Event"
    And I should see "Updated Link"
    
  Scenario: delete a link
    Given I am on the event page for "Editable Event"
    When I follow "delete" within "div.event > div.links > p:first-child"
    Then I should see "Link successfully deleted."
    And I should be on the event page for "Editable Event"
    And I should not see "Editable Link"