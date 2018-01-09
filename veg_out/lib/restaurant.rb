require 'pry'
require 'nokogiri'
require 'open-uri'

require_relative "./scraper"
require_relative './cli.rb'
require_relative './enviro.rb'
require_relative "./veg_out/version"




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
      puts "Here are places with options to eat near you!!"
      puts ""
      VegOut::Scraper.show_list
      VegOut::CLI.show_details
  end

  def self.retry
    puts ""
    puts "No nearby restaurants! Sorry!"
    VegOut::CLI.new.start
  end
end
