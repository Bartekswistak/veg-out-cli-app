
class Restaurant
  attr_accessor :name, :distance, :address, :phone, :description

  @@all = []


  def initialize(name, distance, address, phone)
    @name = name
    @distance = distance
    @address = address
    @phone = phone
  end


end
