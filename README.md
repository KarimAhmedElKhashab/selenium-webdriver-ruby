# selenium-webdriver-ruby
A demo e2e test framework using selenium webdriver under ruby

## Dependencies

- install rvm (i.e. in my case i use 2.5.7)
- install latest ruby selenium webdriver https://rubygems.org/gems/selenium-webdriver/versions/4.9.0
- install chromedriver-helper https://rubygems.org/gems/chromedriver-helper
- install rspec --> ```gem install rspec```

## Running tests

You can run any test via ```browser={browser} rspec /path_to_file/test_name.rb```

## Test Reporting via Allure

https://github.com/allure-framework/allure-ruby/blob/master/allure-rspec/README.md

_To run specs with Allure formatter from command line_

    rspec /path/to/example_spec.rb --format AllureRspecFormatter
    
_To generate and view Allure report in HTML format from command line_

    allure generate report/allure-results
    
 Then
 
    allure serve report/allure-results

## Page Object Model and OOP Implementations

Inspired from https://slack.engineering/scaling-end-to-end-user-interface-tests/

 - To abstract UI for better maintainability and scalability you can rely on Class Inheritance OOP concept by having Base parent classes and children classes extending them.
 - Centralized driver class to managae driver main actions and configs
 - Base element class with common Web Element actions
 - Common page helper class that contains common methods that's used across other pages
 - Separate pages to encapsulate each page logic into it's own class/methods

## What is next?

- Separate locators from page objects for better structure, readability and maintainability
- Break down base web element class into sub types like button, link, input...etc. instead of general WebElement. It isn't so comfortable to work with so general web element API. You have a possibility to type text (send keys) to button or to link.
- Leverage driver class to use desired capabilities and red config externally



