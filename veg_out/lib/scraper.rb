require 'pry'
require 'nokogiri'
require 'open-uri'



class Scraper
  html = open("https://www.happycow.net/")
  doc = Nokogiri::HTML("https://www.happycow.net/")

  binding.pry



end
