Feature: Book ordering process
  Background:
    * url 'https://simple-books-api.glitch.me'
    * def tokenCreationFeature = callonce read('classpath:officialpackage/SimpleBooksAPI/tokenCreationFeature.feature')
    * def availableBooksFeature = callonce read('classpath:officialpackage/SimpleBooksAPI/avaiableBooks.feature')
    * def unavailableBooksFeature = callonce read('classpath:officialpackage/SimpleBooksAPI/unavaiableBooks.feature')

#    * def books = call read('classpath:officialpackage/SimpleBooksAPI/books.feature@createToken')

#  $ filter
  Scenario: verify that 'type' filter works correctly on the list of books endpoint (check the case 'fiction' and 'non-fiction')
    Given path '/books'
    When method GET
    Then status 200
#      * print karate.response
    * match karate.response.header('content-type') == 'application/json; charset=utf-8'
#      * match each response contains {type: '#notnull'}
    * match each $ contains { type: "#notnull"}
    * def validTypes = ['fiction', 'non-fiction']
    * match each response contains { type: '#? validTypes.includes(_)' }

  Scenario: verify the successful creation of an order with an available book (book in stock)
    Given path '/orders'
    # Call the scenario that generates the access token and store the response in a variable
    * def generatedAccessToken = tokenCreationFeature.response.accessToken
    # Extract the access token from the response and store it in a variable
    * header Authorization = 'Bearer ' + generatedAccessToken
    * def customerName = tokenCreationFeature.APIClientData.clientName
    * def firstAvailableBookID = availableBooksFeature.bookToOrder.id
    * print firstAvailableBookID
    * request { "bookId": '#(firstAvailableBookID)', "customerName": '#(customerName)' }
    When method POST
    * status 201
    * match $ == '#notnull'
    * match $ contains {orderId: '#notnull'}
    * match $ contains {orderId: '#string'}

  Scenario: verify the unsuccessful creation of order when the book is out of stock
    Given path '/orders'
    # Call the scenario that generates the access token and store the response in a variable
    * def generatedAccessToken = tokenCreationFeature.response.accessToken
    # Extract the access token from the response and store it in a variable
    * header Authorization = 'Bearer ' + generatedAccessToken
    * def customerName = tokenCreationFeature.APIClientData.clientName
    * def firstUnavailableBookID = unavailableBooksFeature.bookToOrder.id
    * request { "bookId": '#(firstUnavailableBookID)', "customerName": '#(customerName)' }
    When method POST
    * status 404
    * match $ == '#notnull'
    * match $ contains {error: '#notnull'}
    * match $ !contains {orderId: '#notnull'}
