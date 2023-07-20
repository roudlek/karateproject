Feature: operations on json
  Background:
    * def userDataFile = read('classpath:userData.json')
  Scenario: defining JSON object and print it
    * def jsonObject =

    """
        [
          {
            "name": "jack",
            "phone" : 15435667788
          },
          {
            "name": "jennie",
            "phone" : 13443567234
          }
        ]
      """
    * def json2 = [{name: "jack",age: 23},{name: "jimmy",age: 45}]
    * print jsonObject[0].name, jsonObject[0].phone
    * print karate.pretty(json2)

  Scenario: reading a json file and print it
    * print userDataFile

  Scenario: requesting a json body from our folders
    Given url 'https://reqres.in/api/users'
    * request userDataFile
    When method POST
    Then status 201
    And match $ ==
    """
  {
  "name": "morpheus",
  "job": "leader",
  "id": "#notnull",
  "createdAt": "#notnull"
  }
  """