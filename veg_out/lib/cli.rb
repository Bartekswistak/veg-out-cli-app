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
    puts ""
    puts "Please enter the name of your city, or a 5 digit zip code:"
    input = gets.strip.to_s
    @doc = Nokogiri::HTML(open("https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=20&distanceType=mi&limit=25"))
    show_restaurants
  end

  def show_restaurants
    @restaurants = @doc.css("h5").map {|name| name.text}.uniq
    @distance = @doc.css("span.distance").map {|howfar| howfar.text}.uniq
      if @restaurants == [ ]
        puts "No nearby restaurants! Sorry!"
        start
      else
        @restaurants.each_with_index.map {|n, index| puts "#{index + 1}. #{n} -- #{@distance[index]} away"}
      more_info
    end
  end


  def more_info
    puts ""
    puts "For more information, enter: locations, restaurants, start over or quit"
      input = gets.strip
        case input
        when "start over"
           start
        when "locations"
           show_addresses
        when "restaurants"
           show_restaurants
        when "quit"
           exit
         when "1..25"
           open_details_page
        else
           puts ""
           puts "Not a valid choice"
           more_info
        end
    end

  def show_addresses
    address = @doc.css("div.details").children.css("p").map {|location| location.text}
      address.each_with_index.map {|n, i| puts "#{i + 1}. #{n}"}
    more_info
  end

  def open_details_page
    details = @doc.css("div.thumbnail__box a").map {|link| link['href']}.uniq
    site = "happycow.net"


  end

end
