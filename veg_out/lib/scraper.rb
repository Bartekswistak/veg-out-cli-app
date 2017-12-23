require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'



class Scraper
  html = open("https://www.happycow.net/searchmap?lat=&lng=&location=34293")
  doc = Nokogiri::HTML(html)


binding.pry  




end
