require "selenium-webdriver"
require "rspec"
require_relative '../locators/form_test_page'
require_relative '../pages/form_test_page'
include Pages

$first_name = 'John'
$last_name = 'Doe'
$job_title = 'QA'
$date = '05/25/2025'
$expected_banner_text = 'The form was successfully submitted!'

def setup(browser)
  $driver = Selenium::WebDriver.for browser
  $driver.manage.window.maximize
  $driver.manage.timeouts.implicit_wait = 5
  ENV['base_url'] = 'https://formy-project.herokuapp.com/form'

end

def teardown
  $driver.quit
end

describe "automating a form" do

  # Before all block where we need initialize all the pages that is going to be used across this file
  before(:each) do
    # init driver
    setup(:chrome)

    #init pages
    @form_test_page = FormTestPage.new($driver)

    # init log to console
    @log = Logger.new($stdout)
  end

  after(:each) do
    $driver.quit
  end


  it "submits a form" do

    $driver.navigate.to "https://formy-project.herokuapp.com/form"
    @log.info "User goes to Form Page"

    @form_test_page.submit_form
    @log.info "User fills all form fields and submits the form"

    actual_banner_text = @form_test_page.get_banner_text
    expect(actual_banner_text).to eql($expected_banner_text)
    @log.info "Actual message displayed after submitting the form successfully is ==> #{$expected_banner_text}"
    @log.info "Expected message displayed after submitting the form successfully is ==> #{actual_banner_text}"

  end
end
