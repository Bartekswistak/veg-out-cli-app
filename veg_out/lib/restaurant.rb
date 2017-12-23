
class Restaurant
  attr_accessor :name, :distance, :address, :phone, :description


  def initialize(name, distance, address, phone)
    @name = name
    @distance = distance
    @address = address
    @phone = phone
  end


end
