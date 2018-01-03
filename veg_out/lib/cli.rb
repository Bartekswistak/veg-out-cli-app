require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative "./veg_out/version"


class VegOut::CLI

  def call
    puts ""
    puts "                    Welcome to Veg Out   "
    puts "                    ------------------   "
    puts "The best place to find vegan and vegetarian restaurants!!"
    puts ""
    start
  end

  # Takes the user input of either zip code or city/st or address and inserts into the url after the location tag

  def start
    puts ""
    puts "Please enter the name of your city, or a 5 digit zip code:"
    input = gets.strip.to_s
    @doc = Nokogiri::HTML(open("https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=20&distanceType=mi&limit=25"))
    show_restaurants
  end

  # This method scrapes the results page and gets an array of restaurants, then iterates over the array
  # and returns a numbered list with the distance from the location given.

  def show_restaurants
    @restaurants = @doc.css("h5").map {|name| name.text}.uniq
    @distance = @doc.css("span.distance").map {|howfar| howfar.text}.uniq
      if @restaurants == [ ]
        puts "No nearby restaurants! Sorry!"
        start
      else
        puts "Here are places with options to eat near you!!"
        puts ""
        @restaurants.each_with_index.map {|n, index| puts "#{index + 1}. #{n} -- #{@distance[index]} away"}
      more_info
    end
  end

  # This method takes user input to show more details of a specific restaurant or give options to navigate elsewhere.

  def more_info
    puts ""
    puts "For more information on a restaurant, type 'more' "
    puts "If you would like to see the list of restaurants again type 'list'"
    puts "Or to search a new area type 'back' or type 'quit' to exit "
    puts ""
      input = gets.strip
        case input
          when "back"
             start
          when "quit"
             exit
          when "more"
             show_details
           when "list"
             show_restaurants
          else
             puts ""
             puts "Not a valid choice"
             more_info
          end
    end

    # The idea here is take user input, and take the appropriate link from details
    # and add it to the base site variable, from there more details will be scraped and displayed.

    def show_details
      puts "Which restaurant are you interested in learing more about:"
      @info = gets.strip.to_i
      details = @doc.css("div.thumbnail__box a").map {|link| link['href']}.uniq
      base_url = "https://www.happycow.net"

      site = base_url << details[@info-1].to_s
      deets = Nokogiri::HTML(open(site))

        puts ""
        puts deets.css("h1.header__title").text 
        puts ""
        puts deets.css("div.venue__description.mb--3").children.css("p").text
        puts ""
        puts "Contact Info:"
        puts deets.css("div.icon__text").children.css("span").first.text
        puts ""
        puts "Location:"
        puts deets.css("p.icon__text__desc").text.strip
        puts ""
        more_info
      end
end
