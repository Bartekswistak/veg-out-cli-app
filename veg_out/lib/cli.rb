require 'pry'
require 'nokogiri'
require 'open-uri'


class VegOut::CLI

  def call
    puts ""
    puts "                    Welcome to Veg Out   "
    puts "                    ------------------   "
    puts "The best place to find vegan and vegetarian restaurants!!"
    puts ""
    start
  end

  def start
    puts "Please enter your 5 digit zip code:"
    input = gets.strip.to_s
    url = "https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=15&distanceType=mi&limit=18"
    html = open(url)
    @doc = Nokogiri::HTML(html)
    show_restaurants
  end

  def show_restaurants
      @restaurants = @doc.css("h5").map {|name| name.text}.uniq
        @restaurants.each_with_index.map {|n, i| puts "#{i + 1}. #{n}"}

      puts "For more information on a restaurant, type locations to show addresses or type restart to start over:"
        input = gets.strip
        case input
        when "restart"
           start
         when "locations"
           show_addresses
        end

  end

  def show_addresses
    address = @doc.css("div.details").children.css("p").map {|location| location.text}
    address.each_with_index.map {|n, i| puts "#{i + 1}. #{n}"}
  end


end
