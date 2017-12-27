require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'

class Scraper

    puts "Please enter your 5 digit zip code:"
    input = gets.strip.to_s
    url = "https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=15&distanceType=mi&limit=18"
    html = open(url)
    doc = Nokogiri::HTML(html)

    restaurants = doc.css("h5").map {|name| name.text}.uniq
    distance = doc.css("span.distance").map {|howfar| howfar.text}.uniq
    address = doc.css("div.details").children.css("p").map {|location| location.text}


binding.pry

end
