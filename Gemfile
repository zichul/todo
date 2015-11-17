source 'https://rubygems.org'
ruby "2.2.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Authentication
gem 'sorcery'

#Secure tokens
gem 'has_secure_token'
# Frontend

gem 'bootstrap-sass'
gem "haml-rails"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Puma Server
gem "puma"

#Postgresql
gem 'pg'

gem 'socky-authenticator', '~> 0.5.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#
group :production do
  gem 'rails_12factor'
end

group :development, :test do
  # Debugger
  gem 'byebug'


  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'

  gem 'database_cleaner'
  # preloader
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'guard-livereload', '~> 2.5.1'
  gem 'guard-rspec'
  gem 'guard-puma'
end

