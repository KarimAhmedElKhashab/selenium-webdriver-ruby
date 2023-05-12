# selenium-webdriver-ruby
A demo e2e test framework using selenium webdriver under ruby

## Dependencies

- install latest ruby selenium webdriver https://rubygems.org/gems/selenium-webdriver/versions/4.9.0
- install chromedriver-helper https://rubygems.org/gems/chromedriver-helper
- install rspec --> ```gem install rspec```

## Running tests

You can run any test via ```rspec /path_to_file/test_name.rb```

## Option A - Allure Test Reporting:

https://github.com/allure-framework/allure-ruby/blob/master/allure-rspec/README.md

To run specs:

    rspec /path/to/example_spec.rb --format AllureRspecFormatter
    
To generate Allure report in HTML format

    allure generate path/to/results

//TODO ITEMS

## Parallel tests

## Selenium Grid

## Page Object Model


