
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "veg_out/version"

Gem::Specification.new do |spec|
  spec.name          = "veg_out"
  spec.version       = VegOut::VERSION
  spec.authors       = ["Bartek Swistak"]
  spec.email         = ["bartekswistak24@gmail.com"]

  spec.summary       = "Shows nearby vegan and vegetarian restaurants"
  spec.description   = "Takes user input and displays nearby restaurants with vegan/vegetarian options and provides more details on specific restaurants."
  spec.homepage      = "https://github.com/Bartekswistak/veg-out-cli-app"
  spec.license       = "MIT"

  spec.files         = ["lib/veg_out/cli.rb", "lib/veg_out/scraper.rb", "lib/veg_out/restaurant.rb", "lib/enviro.rb"]
  spec.bindir        = "bin"
  spec.executables   << "veg-out"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
end
