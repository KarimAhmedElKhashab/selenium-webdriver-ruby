require "selenium-webdriver"
require "rspec"
require 'yaml'
require_relative '../libraries/driver'
require_relative '../pages/google_search_page'
require_relative '../pages/google_search_results_page'

RSpec.describe "Automating Search engine" do

  # Before all block where we need initialize all the pages that is going to be used across this file
  # and initialize the webdriver

  before(:each) do
    # init driver
    @driver = Driver.new
    @driver.setup(ENV['browser'])

    #init pages
    @google_search_page = GoogleSearchPage.new
    @google_search_results_page = GoogleSearchResultsPage.new

    # read configs
    @test_data = YAML.load_file(Dir.pwd + '/test-data/keywords.yml')
  end

  after(:each) do
    @driver.quit
  end


  it "Searches some keywords in Google" do

    # todo move navigation code to Driver class
    @driver.get(ENV['base_url'])
    puts "User goes to #{ENV["base_url"]}"

    # get search keywords from external file
    search_keywords = @test_data['search_keyword'].split(",")

      # iterate on all keywords to run the test with different keywords
      search_keywords.each do |keyword|
        @google_search_page.clear_and_search_for_keyword(keyword)
        @google_search_results_page.parse_search_results_for keyword
        expect(@google_search_results_page.get_title).to include(keyword)

    end
  end
end
