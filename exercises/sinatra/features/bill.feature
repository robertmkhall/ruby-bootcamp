Feature: Bill page
  The correct bill details will be displayed if the user is logged in

  Scenario: the bill will not be displayed when user not logged in
    Given I am not logged in
    When I go to the 'Bill' page
    Then I will be redirected to the 'Login' page

  Scenario: the bill will be displayed when the user logs in
    Given I am already logged in
    When I go to the 'Bill' page
    Then these bill 'summary' details will be displayed:
      | Generated | 2015-01-11 |
      | Due       | 2015-01-25 |
      | From      | 2015-01-26 |
      | To        | 2015-02-25 |
      | Total     | 136.03     |
    And these 'subscriptions' will be displayed:
      | tv        | Variety with Movies HD | 50.0 |
      | talk      | Sky Talk Anytime       | 5.0  |
      | broadband | Fibre Unlimited        | 16.4 |
      | Total     | 71.4                   |      |
#    And these 'calls' will be displayed:
#      | 07716393769 | 00:23:03 | 2.13 |
#      | 07716393999 | 00:08:11 | 1.22 |
#      | 07716393888 | 00:15:03 | 1.87 |
#      | Total       | 5.22     |      |
    And these 'purchases' will be displayed:
      | Rental   | 50 Shades of Grey   | 4.99 |
      | Purchase | Thats what she said | 9.99 |
      | Purchase | Broke back mountain | 9.99 |
      | Total    | 24.97               |      |
