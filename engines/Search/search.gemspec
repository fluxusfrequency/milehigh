$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "search"
  s.version     = Search::VERSION
  s.authors     = ["fluxusfrequency", "BryanaKnight", "dpequeen", "benhorne44"]
  s.email       = ["bennlewis@gmail.com", "brknig11@gmail.com", "pequickster@msn.com", "benhorne44@gmail.com"]
  s.homepage    = "https://github.com/fluxusfrequency/milehigh"
  s.summary     = "Engine to search data"
  s.description = "Searches data"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
