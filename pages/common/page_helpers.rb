# commonly used methods across pages are centralized here for a higher level of abstraction and reuse to reduce
# maintenance in pages

require_relative '../../base/element'

class PageHelpers < Element

  def initialize
    # init log to console
    @log = Logger.new($stdout)
  end

  # To find the most popular items (i.e. the urls and short descriptions which were found in both search engines)
  # it takes two arrays and filters out the similar items on both
  def compare_two_engines_results(first, second)
    # compare 2 arrays and return similar urls and short descriptions
    @log.info "\e[30mStep # 4 - Compares results from the 2 search engines and logs similar results to stdout...\e[0m\n"

    output = []

    0.upto(first.size - 1) do |i|
      similar_urls = []
      similar_desc = []

      first[i].each do |key, obj|
        first_url = obj[:url]
        first_desc = obj[:description]

        second[i].each do |key2, obj2|
          second_url = obj2[:url]
          second_desc = obj2[:description]

          similar_urls.push(first_url) if first_url == second_url and first_url != nil
          similar_desc.push(first_desc) if first_desc == second_desc and second_url != nil
        end
      end
      similar_urls.uniq!
      similar_desc.uniq!
      output.push({similar_urls: similar_urls, similar_desc: similar_desc})
    end

    @log.info "\n\e[30m######################################### Similar/Popular URLs and Short Descriptions between two search engines #########################################\e[0m\n"
    output.each_with_index do |output, i|
      @log.info "\e[30m#{i+1}th keyword similarities found: #{output}\e[0m"
    end

  end

  # To parse the first 10 results logging to stdout which attributes contains the provided keyword and which not
  # and return a hash of hashes for comparison
  def parse_search_results_for(keyword)
    @log.info "\e[30mStep # 3 - Parsing first few search results...\e[0m"

    final_hash = {}
    # check optimal length to iterate on
    length = if urls.size < short_descriptions.size then urls.size else short_descriptions.size end

    @log.info "#{length} results found"

    # parse results attributes (url, short description)
    1.upto(length - 1) do |i|
      url_text_value = if urls[i].displayed? then urls[i].text else nil end
      desc_text_value = if short_descriptions[i].displayed? then short_descriptions[i].text else nil end
      result_hash = {
          "url": url_text_value,
          "description": desc_text_value,
      }
      final_hash[i] = result_hash
    end

    # iterate to display which attributes contains the search keyword and which not
    found = {}
    not_found = {}
    @log.info "\e[30mDisplaying which attributes contains \"#{keyword}\" and which not...\e[0m\n"
    final_hash.each do |key, value|
      value.each do |k,v|
        if v and v.downcase.include? keyword.downcase
          found[k] = [] unless found[k]
          found[k].push(v)
        else
          not_found[k] = [] unless not_found[k]
          not_found[k].push(v)
        end
      end
    end
    @log.info "\e[32mFound \"#{keyword}\" in the following URLs/Short Descriptions...\e[0m\n"
    puts found
    @log.info "\e[31m\"#{keyword}\" Not found in the following URLs/Short Descriptions...\e[0m\n"
    puts not_found
    return final_hash
  end
end