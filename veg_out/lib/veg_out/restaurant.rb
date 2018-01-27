class VegOut::Restaurant
  attr_accessor :name, :distance, :address, :phone, :description

  @@all = []

  def initialize(name = nil, address = nil, phone = nil, description = nil)
    @name = name
    @address = address
    @phone = phone
    @description = description
    @@all << self
  end

  def self.all
    @@all
  end
end
