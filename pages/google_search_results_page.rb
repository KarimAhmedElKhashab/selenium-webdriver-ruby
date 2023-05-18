require_relative '../base/common_base'

class GoogleSearchResultsPage < CommonBase

  attr_accessor :search_results

  def initialize
    # This super is responsible for passing the driver object into the Base class
    # and making all of its methods run smoothly.
    super

    # init log to console
    @log = Logger.new($stdout)
  end

  # Locators
  # todo: revise this locator to get several attributes in search results as requested in task
  def search_results
    @search_results = find_elements(xpath: '//*[@id="rso"]/div')
    @search_results
  end

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
