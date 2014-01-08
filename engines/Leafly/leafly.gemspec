$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "leafly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "leafly"
  s.version     = Leafly::VERSION
  s.authors     = ["fluxusfrequency", "BryanaKnight", "dpequeen", "benhorne44"]
  s.email       = ["bennlewis@gmail.com", "brknig11@gmail.com", "pequickster@msn.com", "benhorne44@gmail.com"]
  s.homepage    = "https://github.com/fluxusfrequency/milehigh"
  s.summary     = "Engine to comsume store and strain information from Leafly"
  s.description = "Uses Leafly information for the Mile High app"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
  s.add_runtime_dependency 'rolling_paper'
  s.add_runtime_dependency 'mechanize'
  s.add_runtime_dependency 'open-uri'
end
