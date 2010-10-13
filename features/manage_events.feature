Feature: Manage events

  Scenario: create a new event
    Given I am on the events page
    When I follow "Create New Event"
    And I fill in "Name" with "Some New Event"
    And I fill in "Event type" with "Seminar"
    And I fill in "Starting date of event" with "10/14/2010"
    And I fill in "Ending date of event" with "10/14/2010"
    And I fill in "Location" with "Eugene, Oregon"
    And I fill in "Description" with "There will be 4 speakers during 8 hours..."
    And I press "Create Event"
    Then I should see "Event was successfully created."  
  
  Scenario: update an event
    Given I am on the event page for "Editable Event"
    And I follow "Edit Editable Event"
    And I fill in "Name" with "Updated Event"
    And I press "Update Event"
    Then I should see "Event was successfully updated."
    
  Scenario: delete an event
    Given I am on the event page for "Editable Event"
    And I follow "Delete Editable Event"
    Then I should be on the events page
