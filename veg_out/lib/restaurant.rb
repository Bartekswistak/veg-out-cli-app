class Restaurant
  attr_accessor :name, :distance, :address, :phone, :description

  @@all = []

  def initialize(name, distance, address, phone, description)
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
