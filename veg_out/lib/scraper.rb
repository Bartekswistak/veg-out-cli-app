require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'



class Scraper

    url = "https://www.happycow.net/searchmap?lat=&lng=&location="
    puts "Please enter your 5 digit zip code:"
    input = gets.strip
    url << input.to_s
    html = open(url)
    doc = Nokogiri::HTML(html)





binding.pry




end
