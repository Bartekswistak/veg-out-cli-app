require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'

class Scraper

    input = gets.strip.to_s
    url = "https://www.happycow.net/reviews/mango-bistro-englewood-36923"
    html = open(url)
    doc = Nokogiri::HTML(html)


binding.pry

end
