function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
//    var result = karate.callSingle('classpath:some/package/my.feature');
  }
  var config = {
    accessToken: 'something', // Initialize the variable with null
    env: env,
    myVarName: 'someValue',
    baseUrl: 'https://www.google.com',
    someJson: {name:"value1",age: "value2"}

  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  //    var generatedAccessToken = karate.get('generatedAccessToken')
//      var result = karate.callSingle('classpath:officialpackage/SimpleBooksAPI/books.feature');
//      config.authinfo = result;
  return config;
}