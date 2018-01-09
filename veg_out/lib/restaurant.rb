require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative './cli.rb'
require_relative './enviro.rb'
require_relative "./veg_out/version"
require_relative "./scraper"



class VegOut::Restaurant
  attr_accessor :name, :distance, :address, :phone, :description

  @@all = []

  def initialize(name = nil, distance = nil, address = nil, phone = nil, description = nil)
    @name = name
    @distance = distance
    @address = address
    @phone = phone
    @description = description
    @@all << self
  end

  def self.all
    @@all
  end

  def self.show_restaurants
    if @restaurants != []
        VegOut::Scraper.scrape_results
        puts "Here are places with options to eat near you!!"
        puts ""
        VegOut::Scraper.show_list
        VegOut::CLI.show_details
    else
        puts ""
        puts "No nearby restaurants! Sorry!"
        VegOut::CLI.start
    end
  end
end
