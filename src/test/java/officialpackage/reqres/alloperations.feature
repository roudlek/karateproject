Feature: operations to test on reqres.in
  Background:
    * url "https://reqres.in/"
  Scenario: login successfully using post method
    Given path "api/login"
    And request {"email": "eve.holt@reqres.in","password": "cityslicka"}
    When method post
    Then status 200
    And match $ == {"token": "QpwL5tke4Pnpja7X4"}
    And match $ == '#notnull'
#    dollar sign stands for response

  Scenario: create a user
    Given path '/api/users'
    And request {"name":"morpheus","job":"leader"}
    When method POST
    Then status 201
    And match $ == {"name":"morpheus","job":"leader","id":"#notnull","createdAt":"#notnull"}

  Scenario: login fail without password using post method
    Given path "api/login"
    And request {"email": "peter@klaven"}
    When method post
    Then status 400
    And match $ == {"error": "Missing password"}

  Scenario: Single user not found
    Given path "/api/users/23"
    When method get
    Then status 404
    And match $ == {}

  Scenario: Single resource
    Given path "/api/unknown/2"
    When method get
    Then status 200
    And match $ ==

"""
{
        "data": {
            "id": 2,
            "name": "fuchsia rose",
            "year": 2001,
            "color": "#C74375",
            "pantone_value": "17-2031"
        },
        "support": {
            "url": "https://reqres.in/#support-heading",
            "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
        }
}
"""

  Scenario: Update user details
    Given path '/api/users/2'
    And request { "name": "morpheus", "job": "zion resident" }
    When method PUT
    Then status 200
    And match response == { "name": "morpheus", "job": "zion resident", "updatedAt": "#notnull" }

  Scenario: delete a user
    Given path '/api/users/2'
    When method DELETE
    Then status 204