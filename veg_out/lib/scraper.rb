require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './restaurant.rb'
require_relative './cli.rb'
require_relative './enviro.rb'
require_relative "./veg_out/version"


class VegOut::Scraper

  def self.get_page
    input = gets.strip.to_s
    @doc = Nokogiri::HTML(open("https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=20&distanceType=mi&limit=25"))
  end

  def self.create_restaurant
    VegOut::Restaurant.new(
        @doc.css("h5").map {|name| name.text}.uniq,
        @doc.css("span.distance").map {|howfar| howfar.text}.uniq,
      )

  end

  def self.scrape_results
    @restaurants = @doc.css("h5").map {|name| name.text}.uniq
    @distance = @doc.css("span.distance").map {|howfar| howfar.text}.uniq
  end

  def self.show_list
    @restaurants.each.with_index(1).map {|n, index| puts "#{index}. #{n} -- #{@distance[index]} away"}
  end

  def self.find_details_page
    @info = gets.strip.to_i
      if @info > @restaurants.size
        puts "Invalid choice. Select a number from the list above:"
        self.find_details_page
      else
    details = @doc.css("div.thumbnail__box a").map {|link| link['href']}.uniq
    base_url = "https://www.happycow.net"
    site = base_url << details[@info-1].to_s
    @deets = Nokogiri::HTML(open(site))
      end
  end

  def self.more_details
    puts ""
    puts @deets.css("h1.header__title").text
    puts ""
    puts @deets.css("div.venue__description.mb--3").children.css("p").text
    puts ""
    puts "Contact Info:"
    puts @deets.css("div.icon__text").children.css("span").first.text
    puts ""
    puts "Location:"
    puts @deets.css("p.icon__text__desc").text.strip
    puts ""
  end
end
