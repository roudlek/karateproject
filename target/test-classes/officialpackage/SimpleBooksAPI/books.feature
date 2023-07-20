Feature: books API operations
  Background:
    * def APIClientData = read('classpath:officialpackage/SimpleBooksAPI/APIClientData.json')
    * url 'https://simple-books-api.glitch.me'

  Scenario: verify the creation of token after an authentication
        # JavaScript function to generate a random email address
    * def generateRandomEmail =
    """
      function() {
        return Math.random().toString(36).substring(2, 11) + '@example.com';
      }
    """
    Given path '/api-clients/'
    # We set the generated prefix of our json file of clientEmail to the returned value of the js function
    * set APIClientData.clientEmail = generateRandomEmail()
    * match APIClientData contains { clientEmail: '#regex ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'} # Validate email format
    * match APIClientData contains { clientName: '#notnull' }
    * request APIClientData
    When method POST
    Then status 201
    * match $ == '#notnull'
    * match $.accessToken == '#notnull'
    * match $.accessToken == '#string'
    # Validate access token format (64 characters hexadecimal)
    * match $ == { accessToken: '#regex ^[0-9a-f]{64}$'}
#    * match karate.request.clientName == '#ignore'
#    karate.request has a lot pf parameters
    * print karate.request
    * print karate.response
    * match karate.request.post == true
    * match karate.response.dataType == 'json'
    * match $ !contains { error: "API client already registered. Try a different email."}

  Scenario:
    Given path