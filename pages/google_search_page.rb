require_relative '../base/common_base'

class GoogleSearchPage < CommonBase
  # Locators
  Search_bar = {name: "q"}

  def initialize
    # This super is responsible for letting page inherit Base class and making all of
    # its methods available for use within the page logic.
    super

    # init log to console
    @log = Logger.new($stdout)
  end

  def clear_and_search_for_keyword(keyword = '')
    clear(Search_bar)
    type(Search_bar, keyword)
    type(Search_bar, :return)
    @log.info "Step # 2 - User types \"#{keyword}\" in search bar and presses enter"
  end
end
