Feature: XML operations
  Scenario: testing XML
    * def employeesData = <employees><employee><name>aziz</name><age>23</age></employee><employee><name>hamid</name><age>44</age></employee></employees>
    * print karate.pretty(employeesData)
#    * print EmployeesData
    * match employeesData.employees.employee[0].name == 'aziz'
    * match employeesData.employees.employee[1].name == 'hamid'
    * def age1 = employeesData.employees.employee[0].age
    * match (age1 * 1) == 23
#    * match employeesData.employees.employee[1].age * 1 == 44
  # it also works with no (), but it gives red lines under line, but it doesn't give the comliation error
#    to convert to number we multiply to 1
    * match (employeesData.employees.employee[0].age * 1) == 23
    # or use parseInt(your expression here)
    * match parseInt(employeesData.employees.employee[0].age) == 23
#    index starts from 1 when using the slashes /
    * match employeesData/employees/employee[1]/name == 'aziz'
    * match employeesData/employees/employee[1]/age == '23'
    * match employeesData.employees.employee[0].age == '23'
