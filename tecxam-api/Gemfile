source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# For authentication
gem 'devise-jwt'
# For User::Create
gem 'active_type'
# JSON Serializer
gem 'jbuilder'
# For ENV vars
gem 'dotenv'
# For exporting exams to PDF
gem 'date'
gem 'rulex'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'pundit'

gem 'loofah'


group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :development, :test do
  gem 'bundler-audit', require: false
  gem 'bullet'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'sinatra'
  gem 'database_cleaner'
  gem 'spring-commands-rspec', '1.0.4'
  gem 'json-schema'
  gem 'prickle'
  gem 'shoulda-matchers', '~> 3.1.0'
  gem 'faker'
  gem 'json_matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
