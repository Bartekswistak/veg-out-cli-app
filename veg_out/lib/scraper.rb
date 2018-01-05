require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'
require_relative './cli.rb'
require_relative './enviro.rb'

module VegOut::Scraper

  def get_page
    input = gets.strip.to_s
    @doc = Nokogiri::HTML(open("https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=20&distanceType=mi&limit=25"))
  end

  def scrape_results
    @restaurants = @doc.css("h5").map {|name| name.text}.uniq
    @distance = @doc.css("span.distance").map {|howfar| howfar.text}.uniq
  end

  def show_list
    @restaurants.each_with_index.map {|n, index| puts "#{index + 1}. #{n} -- #{@distance[index]} away"}
  end

end
