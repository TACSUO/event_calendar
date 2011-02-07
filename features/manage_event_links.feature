Feature: Manage event links

  Scenario: create a new link
    Given I am on the event page for "Linkable Event"
    Then I should see "Time: 09:00 AM - 10:00 AM Eastern / 08:00 AM - 09:00 AM Central / 07:00 AM - 08:00 AM Mountain / 06:00 AM - 07:00 AM Pacific"
    When I fill in "Name" with "H20 is not scarce"
    And I fill in "URL" with "water.example.com"
    And I fill in "Description" with "Statistics, Analysis and News regarding the sudden and unexpected rise in the population of water molecules."
    And I press "Create Link"
    Then I should see "Link successfully created."
    And I should be on the event page for "Linkable Event"
    And I should see "H20 is not scarce"
    And I should see "http://water.example.com"
    And I should see "Time: 09:00 AM - 10:00 AM Eastern / 08:00 AM - 09:00 AM Central / 07:00 AM - 08:00 AM Mountain / 06:00 AM - 07:00 AM Pacific"
  
  Scenario: edit a link
    Given I am on the event page for "Linkable Event"
    When I follow "edit" within "div.event > div.links > p:first-child"
    Then I should be on the edit link page for "Linkable Event" "Editable Link"
    When I fill in "Name" with "Updated Link"
    And I fill in "URL" with "example.com"
    And I press "Update Link"
    Then I should see "Link successfully updated."
    And I should be on the event page for "Linkable Event"
    And I should see "Updated Link"
    
  Scenario: delete a link
    Given I am on the event page for "Linkable Event"
    When I follow "delete" within "div.event > div.links > p:first-child"
    Then I should see "Link successfully deleted."
    And I should be on the event page for "Linkable Event"
    And I should not see "Linkable Link"