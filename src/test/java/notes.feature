Feature:dsd
  Scenario: you can create functions seperatly and they will still know each other
    * def generateTLD =
    """
      const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      const tld = randomString().slice(0, Math.floor(Math.random() * 62) + 2);

      function randomString() {
        let result = '';
        for (let i = 0; i < 63; i++) {
          const randomIndex = Math.floor(Math.random() * characters.length);
          result += characters.charAt(randomIndex);
        }
        return result;
      }
    """
    * def generateRandomClientEmail =
    """
      function generateRandomClientEmail() {
        const randomString = () => Math.random().toString(36).substring(2);
        const username = randomString().slice(0, Math.floor(Math.random() * 64) + 1);
        const domain = randomString().slice(0, Math.floor(Math.random() * 253) + 2);

        return `${username}@${domain}.${tld}`;
        generateRandomClientEmail();
      }
    """
    #    * match karate.request.clientName == '#ignore'
#    karate.request has a lot pf parameters
#    * print karate.response
#    * match karate.request.post == true
#    * match karate.response.dataType == 'json'
#    * match $ !contains { error: "API client already registered. Try a different email."}
#    * request { "clientName": "#notnull", "clientEmail": "#(generateRandomEmail())" } # calling a js function as param
#    * print APIClientData

using external files:
  function generateTLD() {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  let result = '';
  for (let i = 0; i < 63; i++) {
  const randomIndex = Math.floor(Math.random() * characters.length);
  result += characters.charAt(randomIndex);
  }
  return result;
  }

  function generateRandomClientEmail() {
  const tld = generateTLD().slice(0, Math.floor(Math.random() * 62) + 2);
  const randomString = () => Math.random().toString(36).substring(2);
  const username = randomString().slice(0, Math.floor(Math.random() * 64) + 1);
  const domain = randomString().slice(0, Math.floor(Math.random() * 253) + 2);
  return `${username}@${domain}.${tld}`;
  }
  In your Karate feature file, you can read the content of the customFunctions.js file and evaluate it as JavaScript code:

  cucumber
  Copy code
  Background:
    * def APIClientData = read('classpath:officialpackage/SimpleBooksAPI/APIClientData.json')
    * url 'https://simple-books-api.glitch.me'

    * def customFunctionsJs = read('classpath:officialpackage/SimpleBooksAPI/customFunctions.js')

  # Concatenate the content of customFunctions.js with an eval statement
    * def customFunctions = """
    ${customFunctionsJs}

    eval(generateTLD);
    eval(generateRandomClientEmail);
    """
  The customFunctions variable now contains both the content of customFunctions.js and the eval statements to execute the functions. You can now call generateRandomClientEmail function as before:

  cucumber
  Copy code
  Scenario: verify the creation of token after an authentication
    * eval customFunctions

    * def randomEmail = generateRandomClientEmail()
    * print randomEmail
    * set APIClientData.clientEmail = randomEmail
  With this approach, the JavaScript functions from the external file should be successfully evaluated, and you can use them in your Karate feature without the "Missing close quote" error.


#
#    * print accessToken
      # Store the generatedAccessToken in a global variable
#    * karate.set('generatedAccessToken', result.response.accessToken)
