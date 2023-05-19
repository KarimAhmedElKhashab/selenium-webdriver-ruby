require "selenium-webdriver"
require "rspec"
require 'yaml'
require_relative '../libraries/driver'
require_relative '../pages/google_search_page'
require_relative '../pages/google_search_results_page'

RSpec.describe "Automating Search engine" do

  # Before each block where we need initialize all the pages that is going to be used across this file
  # and initialize the webdriver

  before(:each) do
    # init driver
    @driver = Driver.new
    @driver.setup(ENV['browser'])

    #init pages
    @google_search_page = GoogleSearchPage.new
    @google_search_results_page = GoogleSearchResultsPage.new

    # read test data externally
    @test_data = YAML.load_file(Dir.pwd + '/test-data/keywords.yml')
  end

  after(:each) do
    @driver.quit
  end


  it "Searches some keywords in Google" do

    # navigate to google search engine if nothing else is provided in the env variable
    @driver.get(ENV['base_url'] || "https://www.google.com")

    # get search keywords from external file
    search_keywords = @test_data['search_keyword'].split(",")

    # iterate on all keywords to run the test with different keywords
    search_keywords.each do |keyword|
      # type keyword in search bar and press enter
      @google_search_page.clear_and_search_for_keyword(keyword)

      # assert results loaded
      expect(@google_search_results_page.is_search_results_displayed?).to be_truthy

      # save results hash to global variable for comparison with 2nd engine results
      $google_results = @google_search_results_page.parse_search_results_for keyword
    end
  end

  it "Searches some keywords in 2nd engine then compare results with Google results" do
    #TODO
  end
end
