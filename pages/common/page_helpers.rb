# commonly used methods across pages are centralized here

require_relative '../../base/element'

class PageHelpers < Element

  def initialize
    # init log to console
    @log = Logger.new($stdout)
  end

  # To find the most popular items (i.e. the ones which were found in both search engines)
  # it takes two hashes and filters out the similar ones
  def compare_two_engines_results(first, second)
    # if value of first matches value of second
    @log.info "Step # 4 - Comparing results from two engines...\n"
    @log.info "#########################################First engine results#########################################\n"
    puts first
    @log.info "#########################################Second engine results#########################################\n"
    puts second

    # compare 2 arrays and return similar urls and short descriptions
    urls = first.inject([]) { |memo, hash| memo << hash if second.any? { |hash2| hash[:url] == hash2[:url] }; memo }
    short_descriptions = first.inject([]) { |memo, hash| memo << hash if second.any? { |hash2| hash[:description] == hash2[:description] }; memo }

    @log.info "#########################################Similar URLs#########################################\n"

    urls.each do |url|
      # TODO: log urls only to stdout
      puts url
    end

    @log.info "#########################################Similar Short Descriptions#########################################\n"

    short_descriptions.each do |desc|
      # TODO: log urls only to stdout
    puts desc
    end

  end

  # To parse the first 10 results logging to stdout which attributes contains the provided keyword and which not
  # and return a hash of hashes for comparison
  def parse_search_results_for(keyword)
    @log.info "Step # 3 - Parsing first few search results..."

    final_hash = {}

    # parse results attributes (title, url, short description) 10 times for the first 10 results
    1.upto(5) do |i|
      url_text_value = if urls[i].displayed? then urls[i].text else nil end
      # title_text_value = if titles[i].displayed? and titles[i].text.downcase.include? keyword.downcase then titles[i].text else nil end
      desc_text_value = if short_descriptions[i].displayed? then short_descriptions[i].text else nil end
      result_hash = {
          # "title": title_text_value,
          "url": url_text_value,
          "description": desc_text_value,
      }
      final_hash[i] = result_hash
    end

    final_hash.each do |key, value|
      value.each do |k,v|
        if v and v.downcase.include? keyword.downcase
        then @log.info "Found \"#{keyword}\" in #{k}: \"#{v}\""
        else @log.warn "Could not find \"#{keyword}\" in #{k}: \"#{v}\"" end
      end
    end
    return final_hash
  end

end