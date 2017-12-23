require 'pry'
require 'nokogiri'
require 'open-uri'



class Scraper
  html = open("https://www.happycow.net/searchmap?lat=&lng=&location=34293")
  doc = Nokogiri::HTML(html)

  binding.pry



end
