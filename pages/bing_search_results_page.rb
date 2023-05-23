# A separate page describing bing search results page

require_relative '../base/element'
require_relative '../pages/common/page_helpers'

class BingSearchResultsPage < PageHelpers

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

  Search_results = {xpath: '//*[@id="b_results"]/li'}
  Search_stats = {id: 'b_tween'}
  Titles = { class: "tptxt"}
  Urls = { xpath: "//*[@id=\"b_results\"]/li//h2/a" }
  Short_descriptions = { tag_name: "p"}

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

  # To return whether the search results page is displayed with the needed elements
  def is_search_results_displayed?
    flag = displayed?(Search_stats) || displayed?(Search_results) || displayed?(Titles) || displayed?(Urls) || displayed?(Short_descriptions)

    if flag
      @log.info "\e[32mSearch results page is loaded successfully\e[0m"
    else
      @log.error "\e[31mThere is a problem with loading search results\e[0m"
    end
    flag
  end

end
