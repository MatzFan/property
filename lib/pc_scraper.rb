class PC_Scraper

  PC_URL = "http://www.jerseypost.com/tools/postcode-address-finder/"
  CLICK = "Click here for address information"

  attr_reader :addresses

  def initialize(search_string)
    @search_string = search_string
    @addresses = []
  end

  def get_addresses
    if num_addresses > 0
      (0..num_addresses).step(100) { |i| get_addresses_on_page(i) }
    end
  end

  private
  def get_addresses_on_page(page_num)
    address_block = get_source(page_num).match(/#{CLICK}>(.*)<\/select>/mu)[1]
    adds = address_block.split(/<\/?option>/).map(&:strip)
    # need to select only odd values, as even ones are ""
    new_addresses = adds.values_at(* adds.each_index.select {|i| i.odd?})
    @addresses << new_addresses
  end

  def num_addresses
    num = get_source(0).match(/<h3>There are <span>(.*) results/)[1]
    num == 'no' ? 0 : num.to_i
  end

  def get_source(page_num)
    @source = `curl -s #{PC_URL} -G -d string=#{@search_string}\
               -d search=Find+an+Address -d first=#{page_num}`
  end

end
