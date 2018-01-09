require_relative './cli.rb'
require_relative './enviro.rb'
require_relative "./veg_out/version"


class Restaurant
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


end
