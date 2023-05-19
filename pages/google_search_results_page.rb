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
  Titles = { xpath: "//*[@id=\"rso\"]//a//cite"}
  Urls = { xpath: "//*[@id=\"rso\"]//a/h3" }
  Short_descriptions = { xpath: "//*[@id=\"rso\"]/div/div/div/div[2]"}

  def search_results
    bypass_captcha_manually
    find_elements(Search_results)
  end

  def titles
    bypass_captcha_manually
    find_elements(Titles)
    end

  def urls
    bypass_captcha_manually
    find_elements(Urls)
    end

  def short_descriptions
    bypass_captcha_manually
    find_elements(Short_descriptions)
  end

  def search_results_stats
    find(Search_stats)
  end

  # ====================================================================================================================
  # PAGE METHODS
  # ====================================================================================================================

  # To manually bypass to CAPTCHA/re-CAPTCHA to avoid Selenium::WebDriver::Error::StaleElementReferenceError
  # in case of running on FF
  def bypass_captcha_manually
    if ENV['browser'] == 'ff' || ENV['browser'] == 'firefox'
      sleep 0.5
      puts "CAPTCHA IS HERE!!!"
    end
  end

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
    final_hash = {}

    # iterate on first 10 found results and filter out which contains keyword and which not
    # then print to stout both
    # search_results.each do |result|
    #   break if search_results.find_index(result) == 10 # stop at 10 results
    #   if result.text.downcase.include? keyword.downcase
    #     includes_keyword.push(result.text)
    #   else
    #     excludes_keyword.push(result.text)
    #   end
    # end
    #
    # @log.info "#{includes_keyword.size} search results with \"#{keyword}\" found"
    # includes_keyword.each do |item|
    #   @log.info "=====================================ITEMS FOUND INCLUDING \"#{keyword}\"========================================================"
    #   @log.info "========================================Item # #{includes_keyword.find_index(item) + 1}================================================================================="
    #   @log.info item
    # end
    # @log.info "#{excludes_keyword.size} search results with \"#{keyword}\" not found"
    # excludes_keyword.each do |item|
    #   @log.info "=====================================ITEMS WITHOUT FINDING \"#{keyword}\"========================================================"
    #   @log.info "========================================Item # #{excludes_keyword.find_index(item) + 1}================================================================================="
    #   @log.info item
    # end

    # parse results attributes (title, url, short description) 10 times for the first 10 results
    urls.each_with_index do |url, idx|
      break if idx == 10 # stop at 10 results
      url_text_value = if url.displayed? and url.text.downcase.include? keyword.downcase then url.text else nil end
      result_hash = {
          "url": url_text_value,
      }
      final_hash[idx] = result_hash
    end

    titles.each_with_index do |title, idx|
      break if idx == 10 # stop at 10 results
      title_text_value = if title.displayed? and title.text.downcase.include? keyword.downcase then title.text else nil end
      result_hash = {
          "title": title_text_value,
      }
      final_hash[idx] = result_hash
    end

    short_descriptions.each_with_index do |short_desc, idx|
      break if idx == 10 # stop at 10 results
      desc_text_value = if short_desc.displayed? and short_desc.text.downcase.include? keyword.downcase then short_desc.text else nil end
      result_hash = {
          "description": desc_text_value,
      }
      final_hash[idx] = result_hash
    end

    # for comparing results from 2 search engines
    puts final_hash
    # TODO: format output to stdout as required in task
    return final_hash
  end
end
