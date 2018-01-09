require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative "./veg_out/version"
require_relative "./scraper"
require_relative './restaurant.rb'
require_relative './enviro.rb'


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
    VegOut::Scraper.get_page
    VegOut::Scraper.scrape_results
    VegOut::Scraper.create_restaurant
  end

  # This method takes user input to show more details of a specific restaurant or give options to navigate elsewhere.

  def self.more_info
    puts ""
    puts "If you would like to see the list of restaurants again type 'list'"
    puts "Or to search a new area type 'back' or type 'quit' to exit "
    puts ""
      input = gets.strip
        case input
          when "back"
            VegOut::CLI.new.start
          when "quit"
             exit
           when "list"
             VegOut::Restaurant.show_restaurants
          else
             puts ""
             puts "Not a valid choice"
             self.more_info
          end
    end

    # The idea here is take user input, and take the appropriate link from details
    # and add it to the base site variable, from there more details will be scraped and displayed.

    def self.show_details
      puts ""
      puts "Which restaurant are you interested in learing more about:"
      VegOut::Scraper.find_details_page
      VegOut::Scraper.more_details
      self.more_info
    end
end
