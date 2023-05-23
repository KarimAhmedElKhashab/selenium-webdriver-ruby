# A separate page describing google search results page

require_relative '../base/element'
require_relative '../pages/common/page_helpers'

class GoogleSearchResultsPage < PageHelpers

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
  Titles = { xpath: "//*[@id=\"rso\"]//a//cite"}
  Urls = { xpath: "//h3" }
  Short_descriptions = { css: "div[data-snf=\"nke7rc\"]"}

  def search_results
    bypass_captcha_manually_for_firefox
    find_elements(Search_results)
  end

  def titles
    bypass_captcha_manually_for_firefox
    find_elements(Titles)
    end

  def urls
    bypass_captcha_manually_for_firefox
    find_elements(Urls)
    end

  def short_descriptions
    bypass_captcha_manually_for_firefox
    find_elements(Short_descriptions)
  end

  def search_results_stats
    find(Search_stats)
  end

  # ====================================================================================================================
  # PAGE METHODS
  # ====================================================================================================================

  # To return whether the search listing page is displayed
  def is_search_results_displayed?
    flag = displayed?(Search_stats) || displayed?(Search_results) || displayed?(Titles) || displayed?(Urls) || displayed?(Short_descriptions)

    if flag
      @log.info "\e[32mSearch results page is loaded successfully\e[0m"
    else
      @log.error "\e[31There is a problem with loading search results\e[0m"
    end
    flag
  end
end
