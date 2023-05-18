# This file holds the driver methods that are going to be used across this framework

require 'selenium-webdriver'

class Driver

  attr_accessor :driver
  $main_driver = nil
  @driver = nil

  def initialize
    # init log to console
    @log = Logger.new($stdout)
  end

  # TO init and setup the driver with some configs
  def setup(browser)
    case browser
    when 'chrome'
      @driver = Selenium::WebDriver.for :chrome
    when 'ff', 'firefox'
      @driver = Selenium::WebDriver.for :firefox
    when 'safari'
      @driver = Selenium::WebDriver.for :safari
    else
      # default to chrome
      @driver = Selenium::WebDriver.for :chrome

    end
    @driver.manage.window.maximize
    @driver.manage.delete_all_cookies
    @driver.manage.timeouts.page_load = 10
    @driver.manage.timeouts.implicit_wait = 30

    $main_driver = self
    return self
  end

  # TO load the browser with specific URL.
  def get(url)
    $main_driver = self
    @driver.get(url)
    @log.info("#{$main_driver} browser is loaded with - #{url}")
  end

  # To quit the current browser driver
  def quit
    @log.info("Quiting the browser - #{$main_driver}")
    @driver.quit
  end

  # To find element in the current browser driver
  def find_element(locator)
    $main_driver = self
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    element = wait.until { @driver.find_element(locator) }
    wait.until { element.displayed? }
    wait.until { element.enabled? }
    element
  end

  # To find multiple elements in the current browser. This returns a list of elements found for a specific locator
  def find_elements(locator)
    $main_driver = self
    return @driver.find_elements(locator)
  end

  def title
    @driver.title
  end

end
