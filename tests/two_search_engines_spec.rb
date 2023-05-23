require "selenium-webdriver"
require "rspec"
require 'yaml'
require_relative '../libraries/driver'
require_relative '../pages/common/page_helpers'
require_relative '../pages/google_search_page'
require_relative '../pages/bing_search_page'
require_relative '../pages/google_search_results_page'
require_relative '../pages/bing_search_results_page'

RSpec.describe "Automating parsing and comparing results from two Search engines" do

  # Before each block where we need initialize all the pages that is going to be used across this file
  # and initialize the webdriver

  before(:each) do
    # init driver
    @driver = Driver.new
    @driver.setup(ENV['browser'])

    #init all pages used in tests here
    @common_page_helper = PageHelpers.new
    @google_search_page = GoogleSearchPage.new
    @bing_search_page = BingSearchPage.new
    @google_search_results_page = GoogleSearchResultsPage.new
    @bing_search_results_page = BingSearchResultsPage.new

    # read test data externally
    @test_data = YAML.load_file(Dir.pwd + '/test-data/keywords.yml')
  end

  after(:each) do
    @driver.quit
  end

  # globals to store search results
  $google_results = []
  $bing_results = []

  it "Searches some keywords in Google" do

    # navigate to google search engine if nothing else is provided in the env variable
    @driver.get("https://www.google.com")

    # get search keywords from external file
    search_keywords = @test_data['search_keyword'].split(",")

    # iterate on all keywords to run the test with different keywords
    search_keywords.each do |keyword|
      # type keyword in search bar and press enter
      @google_search_page.clear_and_search_for_keyword(keyword)

      # assert results loaded
      expect(@google_search_results_page.is_search_results_displayed?).to be_truthy

      # save results hash to global variable for comparison with Bing results
      $google_results.push @google_search_results_page.parse_search_results_for keyword
    end
  end

  it "Searches some keywords in Bing" do

    # navigate to google search engine if nothing else is provided in the env variable
    @driver.get("https://www.bing.com")

    # get search keywords from external file
    search_keywords = @test_data['search_keyword'].split(",")

    # iterate on all keywords to run the test with different keywords
    search_keywords.each do |keyword|
      # type keyword in search bar and press enter
      @bing_search_page.clear_and_search_for_keyword(keyword)

      # assert results loaded
      expect(@bing_search_results_page.is_search_results_displayed?).to be_truthy

      # save results hash to global variable for later comparison with Google results
      $bing_results.push @bing_search_results_page.parse_search_results_for keyword

    end

    # Now compare results from the 2 search engines and logs similar results to stdout
    @common_page_helper.compare_two_engines_results($google_results, $bing_results)
  end
end
