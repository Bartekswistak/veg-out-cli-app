# VegOut

Command Line Interface application to find nearby vegan and vegetarian restaurants.

This is my first application I will be building from scratch.

How it should work:

Welcome the user to Veg Out
Takes user input "zip code or city/state" and return a list of nearby restaurants that offer vegan/vegetarian options.
Asks user if they will like more info on a listed restaurant and will list details such as description, address, phone number, etc..
Source website I will be scraping from is HappyCow.com


## Installation

Clone from GitHub using the following command in your terminal ==>
  git clone git@github.com:Bartekswistak/veg-out-cli-app.git


Add this line to your application's Gemfile:

```ruby
gem 'veg_out'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install veg_out

Once gem is installed, simply type veg-out to run the gem!

## Usage

To run the program from the directory: type " ruby veg_out/bin/veg-out " in your terminal and follow instructions.

After being greeted, user can input either city/state location or 5 digit zip code. If there are no
restaurants in the area, user will be notified and asked for another area. Once an area has restaurants
to show, a numbered list will be displayed with the distance from the location inputted. Next user can select the number of the restaurant the user would like more information on.
User can then type 'back' to search a new area, 'list' to show the list again of nearby restaurants or
'quit' to exit the application. These options are available the moment of showing the details of a specific restaurant.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Bartekswistak/veg-out-cli-app This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the VegOut project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<github username>/veg_out/blob/master/CODE_OF_CONDUCT.md).
