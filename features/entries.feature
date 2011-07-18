Feature: index features
  As a user
  I would like to have a home page
  So that I can easily see today's stuff
  
  Scenario: todays date
    Given I am on the home page
    Then I should see today's date
  
  Scenario: food table
    Given I am on the home page
    Then I should see a table of food

  Scenario: food table
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory | emotional |
      | hamburger | 10oz   | 6:45am    | kitchen  |         |           |
    When I go to the home page
    Then I should see a table of food
     And the food table should contain:
      | Food      | Amount | Time/Place      | Sensory | Emotional | Action        |
      | Hamburger | 10oz   | 6:45am; Kitchen |         |           | Edit / Delete |
      |           |        | /               |         |           |               |
      # ^^^^^ Above is the empty row for the entry form ^^^^^
  
  @javascript
  Scenario: delete item
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory | emotional |
      | hamburger | 10oz   | 6:45am    | kitchen  |         |           |
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
     |           |        | /               |            |           |               |
     # ^^^^^ Above is the empty row for the entry form ^^^^^
  
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