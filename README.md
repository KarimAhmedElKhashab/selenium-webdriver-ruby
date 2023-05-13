# selenium-webdriver-ruby
A demo e2e test framework using selenium webdriver under ruby

## Dependencies

- install latest ruby selenium webdriver https://rubygems.org/gems/selenium-webdriver/versions/4.9.0
- install chromedriver-helper https://rubygems.org/gems/chromedriver-helper
- install rspec --> ```gem install rspec```

## Running tests

You can run any test via ```rspec /path_to_file/test_name.rb```

## Test Reporting via Allure

https://github.com/allure-framework/allure-ruby/blob/master/allure-rspec/README.md

_To run specs with Allure formatter from command line_

    rspec /path/to/example_spec.rb --format AllureRspecFormatter
    
_To generate and view Allure report in HTML format from command line_

    allure generate path/to/results
    
 Then
 
    allure serve path/to/results
   
   

## What is Next?

## Cross browser testing support

Try this https://github.com/crossbrowsertesting/selenium-rspec

## Parallel test execution support

Try this https://github.com/grosser/parallel_tests

## Page Object Model and OOP

 - To abstract UI for better maintainability and scalability you can rely on Class Inheritance OOP concept by having Base parent classes and children classes extending them.
 - Design your POM

## CI support either Jenkins or github actions

## Selenium Grid support for scalability


