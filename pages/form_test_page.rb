module Pages
  class FormTestPage < Base

    FIRST_NAME = {id: 'first-name'}
    LAST_NAME = {id: 'last-name'}

    $first_name = 'John'
    $last_name = 'Doe'
    $job_title = 'QA'
    $date = '05/25/2025'
    $expected_banner_text = 'The form was successfully submitted!'

    def initialize(driver)
      # This super is responsible for passing the driver object into the Base class
      # and making all of its methods run smoothly.
      super
      visit
    end

    def submit_form
      type(FIRST_NAME, $first_name)
      type(LAST_NAME, @last_name)
      @driver.find_element(id: 'last-name').send_keys($last_name)
      @driver.find_element(id: 'job-title').send_keys($job_title)
      @driver.find_element(id: 'radio-button-2').click
      @driver.find_element(id: 'checkbox-2').click
      @driver.find_element(css: 'option[value="2"]').click
      @driver.find_element(id: 'datepicker').send_keys($date)
      @driver.find_element(id: 'datepicker').send_keys :return
      @driver.find_element(css: '.btn.btn-lg.btn-primary').click
    end

    def get_banner_text
      wait = Selenium::WebDriver::Wait.new(timeout: 10)
      wait.until { @driver.find_element(class: 'alert').displayed? }
      banner = @driver.find_element(class: 'alert')
      banner.text
    end

    def visit
      @driver.get ENV['base_url']
    end

  end
end