Feature: Search a OrderCar
  To find a OrderCar
  The User
  Should type in the chassi by the form

  Scenario: Returns the found OrderCar by Chassi
      Given I am on the OrderCar Search page
      And I fill in "order_car_chassi" with "123456"
      When I press "Verkauf Suchen"
      Then page should have content "123456"