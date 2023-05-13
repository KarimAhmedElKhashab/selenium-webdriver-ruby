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
    
_To generate Allure report in HTML format from command line_

    allure generate path/to/results

//TODO ITEMS

## Parallel test execution support

## Selenium Grid support for scalability

## Cross browser testing support

## Page Object Model

## CI support either Jenkins or github actions


