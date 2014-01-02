source 'https://rubygems.org'
gem 'rails', '4.0.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :development, :test do
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'database_cleaner'
  gem 'cane'
  gem 'reek'
  gem 'brakeman', :require => false
end

group :test do
  gem 'rspec-rails'
  gem 'simplecov', :require => false, :group => :test
  gem 'database_cleaner', :require => false, :group => :test
end