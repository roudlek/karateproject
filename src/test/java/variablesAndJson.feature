Feature: variables and json

  Scenario: testing variables and json
    * print 'hello world'
    Given def color = 'red '
    * def num = 5
    * def total = color + num
    Then assert color + num == 'red 5'
    * print color + num
    * def total = color + num + 'printed succesfully'
    * print total
    * def myJson = { foo: 'bar', baz: [1, 2, 3] }
    * print 'the value of myJson is:', myJson
    * print 'the value of myJson is:\n' + karate.pretty(myJson)
    * def cat = {name: 'Billie', scores: [2,5]}
    * assert cat.name != 'Mike'
    * assert cat.name == 'Billie'
    * print cat.scores[1]
#    use match instead of assert, it has more descriptive match failures messages
    * match cat.scores[1] == 5
    * def variable1 = cat.name
    * print variable1
#    now let's see json inside json, big opening and closing is [ and ], and inside we find { and }
    * def dogs = [{name: 'Mike'},{name: 'Lisa',age: 8}]
    * match dogs[0] == {name: 'Mike'}