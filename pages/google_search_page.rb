# A separate page describing google search landing page

require_relative '../base/element'

class GoogleSearchPage < Element

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

  Search_bar = {name: "q"}

  # ====================================================================================================================
  # PAGE METHODS
  # ====================================================================================================================

  def clear_and_search_for_keyword(keyword = '')
    clear(Search_bar)
    type(Search_bar, keyword)
    type(Search_bar, :return)
    @log.info "\e[32mStep # 2 - User types \"#{keyword}\" in search bar and presses enter\e[0m"
  end
end
