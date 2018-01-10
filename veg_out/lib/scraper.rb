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
      @name = @deets.css("h1.header__title").text,
      @address = @deets.css("p.icon__text__desc").text.strip,
      @phone = @deets.css("div.icon__text").children.css("span").first.text,
      @description = @deets.css("div.venue__description.mb--3").children.css("p").text.gsub(/\s+/, " ").strip
      )
  end

  def self.scrape_results
    @restaurants = @doc.css("h5").map {|name| name.text}.uniq
    @distance = @doc.css("span.distance").each_with_index.map {|howfar, i| howfar.text if i.odd?}.uniq
      if @restaurants != []
        VegOut::Restaurant.show_restaurants
      else
        VegOut::Restaurant.retry
      end
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
        self.more_details
      end
  end

  def self.more_details
    self.create_restaurant
    puts ""
    puts @name
    puts ""
    puts @description
    puts ""
    puts "Contact Info:"
    puts @phone
    puts ""
    puts "Location:"
    puts @address
    puts ""
  end
end
