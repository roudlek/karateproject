Feature:
  Background:
  * url 'https://simple-books-api.glitch.me'
  Scenario: get only available books
    Given path '/books'
    When method GET
    Then status 200
    * match karate.response.header('content-type') == 'application/json; charset=utf-8'
    * def availableBooks = karate.filter(response, function(x){ return x.available == true })
    * match availableBooks != null
    * def bookToOrder = availableBooks[0]
    * match $ == '#notnull'
