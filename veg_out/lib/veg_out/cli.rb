class VegOut::CLI

  def call
    puts <<~eos

                        ------------------
                        Welcome to Veg Out
                        ------------------

     The best place to find vegan and vegetarian restaurants near you!!

     eos
     start
  end

  def start
    puts "Please enter the name of your city, or a 5 digit zip code:"

    VegOut::Scraper.get_page
  end

  def self.create_list
    puts <<~eos

      ----------------------------------------------
      Here are places with options to eat near you!!
      ----------------------------------------------
      
    eos

    VegOut::Scraper::restaurants.each_with_index.map {|n, index| puts "#{index+1}. #{n} -- #{VegOut::Scraper::distance[index]} away" }

    self.show_details
  end

  def self.more_info
    puts <<~eos
      If you would like to see the list of restaurants again type 'list'
      To search a new area type 'back' or type 'quit' to exit
    eos


    input = gets.strip
      case input
        when "back"
          VegOut::CLI.new.start
        when "quit"
          exit
        when "list"
          self.create_list
        else
          puts ""
          puts "Not a valid choice!"
          self.more_info
        end
    end

    def self.show_details
      puts ""
      puts "Which restaurant are you interested in learning more about:"
      VegOut::Scraper.find_details_page
    end

    def self.retry
      puts ""
      puts "No nearby restaurants! Sorry!"
      VegOut::CLI.new.start
    end
end
