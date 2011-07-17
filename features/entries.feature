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
      
  Scenario: delete item
    Given I have entries with the following attributes:
      | food      | amount | meal_time | location | sensory | emotional |
      | hamburger | 10oz   | 6:45am    | kitchen  |         |           |
    And I am on the home page
    When I follow "Delete"
    Then there should be no entries
  
  ####### TODO ######
  Scenario: date selector
    Given I am on the home page
    When I click the date
     And I enter date '1/1/01'
     And I press enter
    Then I should be on the home page
    And the date should be '1/1/01'
    
  Scenario: quick add
    Given I am on the home page
    When I enter 'hamburger' in 'food'
     And I enter '10oz' in 'amount'
     And I enter '6:45am' in 'date'
     And I enter 'Kitchen' in "place"
     And I enter "not hungry" in "sensory"
     And I enter "tired" in "emotional"
     And I press enter
    Then I should see table:
      | Hamburger | 10oz | 6:45am; Kitchen | Not hungry | Tired |
    
  Scenario: edit existing entry