class CommonBase

  def initialize
    # init log to console
    @log = Logger.new($stdout)
  end

  # if needed to call visit method while in pages methods
  def visit(driver = $main_driver, url='/')
    driver.get(ENV['base_url'] + url)
    @log.info "User goes to #{ENV["base_url"] + url}"
  end

  # to find and return a single element
  def find(driver = $main_driver, locator)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    element = wait.until { driver.find_element(locator) }
    wait.until { element.displayed? }
    wait.until { element.enabled? }
    element
  end

  # to find and return multiple elements
  def find_elements(driver = $main_driver, locator)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    elements = wait.until { driver.find_elements(locator) }
    elements
  end

  # to clear text
  def clear(locator)
    find(locator).clear
  end

  def type(locator, input)
    find(locator).send_keys input
  end

  def click_on(locator)
    find(locator).click
  end

  def displayed?(driver = $main_driver, locator)
    driver.find_element(locator).displayed?
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def text_of(locator)
    find(locator).text
  end

  def get_title(driver = $main_driver)
    driver.title
  end

end