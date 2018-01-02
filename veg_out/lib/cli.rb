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
    puts "For more information on restaurant, type 'deets' "
    puts "Or to start over type 'back' or type 'quit' to exit "
    puts ""
      input = gets.strip
        case input
          when "back"
             start
  #        when "locations"
  #           show_addresses
  #        when "restaurants"
  #           show_restaurants
          when "quit"
             exit
          when "deets"
             scrape_details_page
          else
             puts ""
             puts "Not a valid choice"
             more_info
          end
    end

#   def show_addresses
#    address = @doc.css("div.details").children.css("p").map {|location| location.text}
#      address.each_with_index.map {|n, i| puts "#{i + 1}. #{n}"}
#    more_info
# end

  def scrape_details_page
    details = @doc.css("div.thumbnail__box a").map {|link| link['href']}.uniq
    list_urls = details.each_with_index.map {|n, i| "#{i + 1}. #{n}"}
    base_url = "https://www.happycow.net"
    site = Nokogiri::HTML(open("https://www.happycow.net"))

    # The idea here is take user input, and take the appropriate link from details
    # and add it to the base site variable, from there more details will be scraped and displayed.

    puts ""
    puts "Enter the number of the restaurant you would like more info on:"
    puts "To go back, type back or type quit to exit"
    puts ""

    input = gets.strip
    case input.to_i
    when 1..26         #method not working properly yet
          puts ""
          puts base_url << details[input.to_i - 1]
          puts ""
#      when "back"
#          show_restaurants
#      when "quit"
#          exit
      else
          puts ""
          puts "Invalid choice!"
          puts ""
      end
      scrape_details_page
end

end
