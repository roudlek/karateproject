Feature: Token creation feature

  Background:
    * def APIClientData = read('classpath:officialpackage/SimpleBooksAPI/APIClientData.json')
    * url 'https://simple-books-api.glitch.me'
#    * config.generatedAccessToken = $generatedAccessToken
#    * def res = callonce read('classpath:officialpackage/SimpleBooksAPI/books.feature')
@createToken
  Scenario: verify the creation of token after an authentication
    # JavaScript function to generate a random email address
    * def generateRandomClientEmail =
    """
  function generateFullEmail(){
      function generateTLD() {
        let result = '';
        for (let i = 0; i < 63; i++) {
          const randomIndex = Math.floor(Math.random() * characters.length);
          result += characters.charAt(randomIndex);
        }
        return result;
      }

      const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      const tld = generateTLD().slice(0, Math.floor(Math.random() * 62) + 2);


      function generateRandomClientEmail() {
        const generateTLD = () => Math.random().toString(36).substring(2);
        const username = generateTLD().slice(0, Math.floor(Math.random() * 64) + 1);
        const domain = generateTLD().slice(0, Math.floor(Math.random() * 253) + 2);
        return `${username}@${domain}.${tld}`;
      }
    return generateRandomClientEmail();
   }
    """
    * def generateRandomClientName =
    """
      function generateRandomClientName() {
        const length = Math.floor(Math.random() * 18) + 3;
        const characters = 'abcdefghijklmnopqrstuvwxyz';
        let name = '';

        for (let i = 0; i < length; i++) {
          const randomIndex = Math.floor(Math.random() * characters.length);
          name += characters[randomIndex];
        }

        return name;
      }
    """
    Given path '/api-clients/'
    # We set the generated prefix of our json file of clientEmail to the returned value of the js function
    * set APIClientData.clientEmail = generateRandomClientEmail()
    * set APIClientData.clientName = generateRandomClientName()
    * match APIClientData contains { clientName: '#notnull' }
    * match APIClientData contains { clientEmail: '#regex ^[a-zA-Z0-9._%+-]{1,64}@[a-zA-Z0-9.-]{1,255}\.[a-zA-Z]{2,63}$'} # Validate email format
    * request APIClientData
    * print karate.request
    When method POST
    Then status 201
    * match $ == '#notnull'
    * match $.accessToken == '#notnull'
    * match $.accessToken == '#string'

    # Validate access token format (64 characters hexadecimal)
    * match $ == { accessToken: '#regex ^[0-9a-f]{64}$'}
    * def generatedAccessToken = $.accessToken


