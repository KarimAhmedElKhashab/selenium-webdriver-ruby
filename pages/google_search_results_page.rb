require_relative '../base/common_base'

class GoogleSearchResultsPage < CommonBase

  def initialize
    # This super is responsible for letting page inherit Base class and making all of
    # its methods available for use within the page logic.
    super

    # init log to console
    @log = Logger.new($stdout)
  end

  # ====================================================================================================================
  # PAGE LOCATORS
  # ====================================================================================================================

  Search_results = {xpath: '//*[@id="rso"]/div'}
  Search_stats = {id: 'result-stats'}
  Title = {}
  Urls = {}
  Short_descriptions = {}

  def search_results
    # a manual bypass to CAPTCHA/re-CAPTCHA to  avoid Selenium::WebDriver::Error::StaleElementReferenceError
    # in case of running on FF
    if ENV['browser'] == 'ff' || ENV['browser'] == 'firefox'
      sleep 0.5
      puts "CAPTCHA IS HERE WITH FF!!!"
    end

    find_elements(Search_results)
  end

  def search_results_stats
    find(Search_stats)
  end

  # ====================================================================================================================
  # PAGE METHODS
  # ====================================================================================================================

  # To return whether the search listing page is displayed
  def is_search_results_displayed?
    flag = displayed?(Search_stats)

    if flag
      @log.info "Search results page is loaded successfully"
    else
      @log.error "There is a problem with loading search results"
    end
    flag
  end

  # todo: revise this locator to get several attributes in search results as requested in task
  # 1- get title list items which includes keyword and which not --> log to stdout
  # 2- get urls list items which includes keyword and which not --> log to stdout
  # 3- get short descriptions items which includes keyword and which not --> log to stdout

  def parse_search_results_for(keyword)
    @log.info "Step # 3 - Parsing first 10 search results..."
    includes_keyword = []
    excludes_keyword = []

    # iterate on first 10 found results and filter out which contains keyword and which not
    # then print to stout both
    search_results.each do |result|
      break if search_results.find_index(result) == 10 # stop at 10 results
      if result.text.downcase.include? keyword.downcase
        includes_keyword.push(result.text)
      else
        excludes_keyword.push(result.text)
      end
    end

    @log.info "#{includes_keyword.size} search results with \"#{keyword}\" found"
    includes_keyword.each do |item|
      @log.info "=====================================ITEMS FOUND INCLUDING \"#{keyword}\"========================================================"
      @log.info "========================================Item # #{includes_keyword.find_index(item) + 1}================================================================================="
      @log.info item
    end
    @log.info "#{excludes_keyword.size} search results with \"#{keyword}\" not found"
    excludes_keyword.each do |item|
      @log.info "=====================================ITEMS WITHOUT FINDING \"#{keyword}\"========================================================"
      @log.info "========================================Item # #{excludes_keyword.find_index(item) + 1}================================================================================="
      @log.info item
    end

    # for comparing results from 2 search engines
    return [includes_keyword, excludes_keyword]
  end
end
