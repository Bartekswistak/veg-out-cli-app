require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative "./veg_out/version"
require_relative "./scraper"
require_relative './restaurant.rb'
require_relative './enviro.rb'


class VegOut::CLI

  def call
    puts "                    ------------------   "
    puts "                    Welcome to Veg Out   "
    puts "                    ------------------   "
    puts ""
    puts "The best place to find vegan and vegetarian restaurants near you!!"
    puts ""
    start
  end

  def start
    puts ""
    puts "Please enter the name of your city, or a 5 digit zip code:"
    VegOut::Scraper.get_page
    VegOut::Scraper.scrape_results
  end

  def self.show_restaurants
    puts "----------------------------------------------"
    puts "Here are places with options to eat near you!!"
    puts "----------------------------------------------"
    VegOut::Scraper.show_list
    self.show_details
  end

  def self.more_info
    puts ""
    puts "If you would like to see the list of restaurants again type 'list'"
    puts "To search a new area type 'back' or type 'quit' to exit "
    puts ""
      input = gets.strip
        case input
          when "back"
            VegOut::CLI.new.start
          when "quit"
             exit
          when "list"
             self.show_restaurants
          else
             puts ""
             puts "Not a valid choice!"
             self.more_info
          end
    end

    def self.show_details
      puts ""
      puts "Which restaurant are you interested in learning more about:"
      VegOut::Scraper.find_details_page
      self.more_details
    end

    def self.retry
      puts ""
      puts "No nearby restaurants! Sorry!"
      VegOut::CLI.new.start
    end

    def self.more_details
      VegOut::Scraper.create_restaurant
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
      self.more_info
    end
end
