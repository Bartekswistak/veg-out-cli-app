class VegOut::Scraper

  def self.get_page
    input = gets.strip.to_s
    @doc = Nokogiri::HTML(open("https://www.happycow.net/searchmap?lat=&lng=&location=#{input}&vegan=true&vegetarian=true&vegfriendly=true&distance=20&distanceType=mi&limit=25"))
    self.scrape_results
  end

  def self.create_restaurant(name = nil, address = nil, phone = nil, description = nil)
    VegOut::Restaurant.new(
      @name = @deets.css("h1.header__title").text,
      @address = @deets.css("p.icon__text__desc").text.strip,
      @phone = @deets.css("div.icon__text").children.css("span").first.text,
      @description = @deets.css("div.venue__description.mb--3").children.css("p").text.gsub(/\s+/, " ").strip
      )
  end

  def self.scrape_results
    @restaurants = @doc.css("h5").map {|name| name.text}.uniq
    @distance = @doc.css("div.grid__group.js-venues").children.css("span.distance").map {|d| d.text}
    class << self
      attr_accessor :restaurants, :distance
    end

      if @restaurants != []
        VegOut::CLI.create_list
      else
        VegOut::CLI.retry
      end
  end

  def self.find_details_page
    info = gets.strip.to_i

      if info > @restaurants.size || info == 0
        puts "Invalid choice. Select a number from the list above:"
        self.find_details_page
      else
        details = @doc.css("div.thumbnail__box a").map {|link| link['href']}.uniq
        @deets = Nokogiri::HTML(open("https://www.happycow.net" << details[info-1].to_s))
        self.more_details
      end
  end

  def self.more_details
    self.create_restaurant

    @name.size.times {print "~"}
    puts ""
    puts @name
    @name.size.times {print "~"}
    puts ""
    puts @description
    puts ""
    puts "Contact Info:"
    puts @phone
    puts ""
    puts "Location:"
    puts @address
    puts ""
    VegOut::CLI.more_info
  end

#  def self.create_list
#    @restaurants.each_with_index.map {|n, index| puts "#{index+1}. #{n} -- #{@distance[index]} away"}
#  end
end
