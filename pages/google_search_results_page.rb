require_relative '../base/common_base'

class GoogleSearchResultsPage < CommonBase

  attr_accessor :search_results, :search_stats

  def initialize
    # This super is responsible for passing the driver object into the Base class
    # and making all of its methods run smoothly.
    super

    # init log to console
    @log = Logger.new($stdout)
  end

  # ====================================================================================================================
  # PAGE LOCATORS
  # ====================================================================================================================

  Search_results = {xpath: '//*[@id="rso"]/div'}
  Search_stats = {id: 'result-stats'}

  def search_results
    @search_results = find_elements(Search_results)
    @search_results
  end

  def search_results_stats
    @search_stats = find(Search_stats)
    @search_stats
  end

  # ====================================================================================================================
  # PAGE METHODS
  # ====================================================================================================================

  # To return whether the search listing page is displayed
  def is_search_results_displayed?
    flag = displayed?(Search_stats)

    if flag
      @log.info "Search results page loaded successfully"
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

    includes_keyword = []
    excludes_keyword = []

    # iterate on first 10 found results and filter out which contains keyword and which not
    # then print to stout both
    search_results.each do |result|
      break if search_results.find_index(result) == 10 # stop at 10 results
      if result.text.include? keyword
        includes_keyword.push(result.text)
      else
        excludes_keyword.push(result.text)
      end
    end
    @log.info "#{includes_keyword.size} search results with \"#{keyword}\" found"
    @log.info "#{excludes_keyword.size} search results with \"#{keyword}\" not found"
  end
end
