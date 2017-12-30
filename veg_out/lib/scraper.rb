require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'

class Scraper

    url = "https://www.happycow.net/searchmap?kw=&location=34293&vegan=true&vegetarian=true&vegfriendly=true&distance=20&distanceType=mi&limit=25"
    html = open(url)
    doc = Nokogiri::HTML(html)


binding.pry

end
