Feature: index features
  As a user
  I would like to have a home page
  So that I can easily see today's stuff
  
  Scenario: todays date
    Given I am on the home page
    Then I should see today's date
  
  Scenario: food table
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory | emotional |
      | hamburger | 10oz   | 6:45am    | kitchen  | sorry   | sad       |
    When I go to the home page
    Then I should see a table of food
     And the food table should contain:
      | Food      | Amount | Time/Place      | Sensory | Emotional | Action        |
      | Hamburger | 10oz   | 6:45am; Kitchen | Sorry   | Sad       | Edit / Delete |
  
  @javascript
  Scenario: delete item
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory | emotional |
      | hamburger | 10oz   | 6:45am    | kitchen  | sorry   | sad       |
    And I am on the home page
    When I follow "Delete"
    Then I should be on the entries page
     And there should be no entries
  
  Scenario: quick add
    Given I am on the home page
    When I fill in "hamburger" for "entry_food"
     And I fill in "10oz" for "entry_amount"
     And I fill in "6:45am" for "entry_meal_time"
     And I fill in "Kitchen" for "entry_location"
     And I fill in "not hungry" for "entry_sensory"
     And I fill in "tired" for "entry_emotional"
     And I press "Create Entry"
    Then I should be on the entries page
    And I should see "Entry was successfully created." within the notice
    And the food table should contain:
     | Food      | Amount | Time/Place      | Sensory    | Emotional | Action        |
     | Hamburger | 10oz   | 6:45am; Kitchen | Not Hungry | Tired     | Edit / Delete |
  
  Scenario: first add of the day requires meal time/location/sensory
    Given I am on the home page
    When I fill in the following:
      | entry_food      | juice |
      | entry_amount    | 8oz   |
      | entry_meal_time |       |
      | entry_location  |       |
      | entry_sensory   |       |
      | entry_emotional |       |
    And I press "Create Entry"
    Then I should be on the entries page
    And I should see "Meal time should be in the form of a time" within the error explanation
    And I should see "Location can't be blank" within the error explanation
    And I should see "Sensory can't be blank" within the error explanation
    And I should see "Emotional can't be blank" within the error explanation
  
  Scenario: Adding with blank time/place/sensory/emotional should copy from previous for the day
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory     | emotional |
      | sausage   | 2oz    | 5:45am    | kitchen  | not hungry  | tired     |
      | hamburger | 10oz   | 12:00pm   | mall     | very hungry | bored     |
    Given I am on the home page
    When I fill in the following:
      | entry_food      | juice |
      | entry_amount    | 8oz   |
      | entry_meal_time |       |
      | entry_location  |       |
      | entry_sensory   |       |
      | entry_emotional |       |
    And I press "Create Entry"
    Then the food table should contain:
      | Food      | Amount | Time/Place      | Sensory     | Emotional | Action        |
      | Sausage   | 2oz    | 5:45am; Kitchen | Not Hungry  | Tired     | Edit / Delete |
      | Hamburger | 10oz   | 12:00pm; Mall   | Very Hungry | Bored     | Edit / Delete |
      | Juice     | 8oz    | 12:00pm; Mall   | Very Hungry | Bored     | Edit / Delete |
      
  Scenario: edit
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory     | emotional |
      | sausage   | 2oz    | 5:45am    | kitchen  | not hungry  | tired     |
      | hamburger | 10oz   | 12:00pm   | mall     | very hungry | bored     |
    Given I am on the home page
    When I follow "Edit"
    Then the "entry_food" field should contain "sausage"
     And the "entry_amount" field should contain "2oz"
     And the "entry_meal_time" field should contain "5:45am"
     And the "entry_location" field should contain "kitchen"
     And the "entry_sensory" field should contain "not hungry"
     And the "entry_emotional" field should contain "tired"
     
  Scenario: update
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory     | emotional |
      | sausage   | 2oz    | 5:45am    | kitchen  | not hungry  | tired     |
    Given I am on the home page
    When I follow "Edit"
     And I fill in the following:
      | entry_food      | juice  |
      | entry_amount    | 8oz    |
      | entry_meal_time | 1:00pm |
      | entry_location  | here   |
      | entry_sensory   | here   |
      | entry_emotional | here   |
     And I press "Update Entry"
     Then I should be on the entries page
      And I should see "Entry was successfully updated." within the notice
      And the food table should contain:
       | Food      | Amount | Time/Place   | Sensory | Emotional | Action        |
       | Juice     | 8oz    | 1:00pm; Here | Here    | Here      | Edit / Delete |

  Scenario: allow partial time
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory     | emotional |
      | sausage   | 2oz    | 5:45am    | kitchen  | not hungry  | tired     |
    Given I am on the home page
    When I follow "Edit"
     And I fill in the following:
      | entry_meal_time | 1pm |
     And I press "Update Entry"
     Then I should be on the entries page
      And I should see "Entry was successfully updated." within the notice
      And the food table should contain:
       | Food      | Amount | Time/Place      | Sensory    | Emotional | Action        |
       | Sausage   | 2oz    | 1:00pm; Kitchen | Not Hungry | Tired     | Edit / Delete |
    
  
  ####### TODO ######
  # Scenario: date selector
  #   Given I am on the home page
  #   When I click the date
  #    And I enter date '1/1/01'
  #    And I press enter
  #   Then I should be on the home page
  #   And the date should be '1/1/01'
  #   
  # Scenario: edit existing entry