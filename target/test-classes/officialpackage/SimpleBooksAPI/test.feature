Feature: dsdsd

  Background:
    * def APIClientData = read('classpath:officialpackage/SimpleBooksAPI/APIClientData.json')
    * url 'https://simple-books-api.glitch.me'

  Scenario: verify the creation of token after an authentication
    * def generateRandomClientEmail = karate.callSingle('classpath:officialpackage/SimpleBooksAPI/customFunctions.js')
    * def clientEmail = generateRandomClientEmail.generateRandomClientEmail()
    * print clientEmail
    * set APIClientData.clientEmail = clientEmail
