# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.5'
gem 'active_model_serializers'
gem 'apipie-rails', require: false
gem 'barby'
gem 'bootsnap', require: false

gem 'breadcrumbs_on_rails'
gem 'chartkick'
gem 'coffee-rails'
gem 'cssbundling-rails', '~> 1.4'
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'dotiw'
gem 'foreman'
gem 'groupdate'
gem 'highcharts-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'listen'
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'
gem 'mini_magick'
gem 'momentjs-rails'
gem 'openweather2'
gem 'os'
gem 'pg'
gem 'puma', '>= 5.0'
gem 'rack-cors'
gem 'rails', '= 7.1.4'
gem 'rails-settings-cached'
gem 'ruby-graphviz'
gem 'sassc-rails'
# gem 'rake'
gem 'hotwire-rails'
gem 'redis', '>= 4.0.1'
gem 'rmagick'
gem 'rqrcode'
gem 'rubyserial'
gem 'seed_dump'
gem 'sidekiq', '>= 6.2.1'
gem 'simple_calendar'
gem 'simple_token_authentication', '~> 1.0'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier'
gem 'whenever', require: false
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap4'
gem 'view_component'
gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
# gem "image_processing", "~> 1.2"
# gem 'hardware_information'
# gem 'open-weather'

install_if -> { RUBY_PLATFORM.include?('linux') } do
  gem 'dht11'
  gem 'dht-sensor-ffi'
  gem 'rpi-dht'
  # gem 'rpi_gpio', git: 'git@github.com:ClockVapor/rpi_gpio.git'
  # gem 'charlcd'
end

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
  gem 'license_finder'
  #gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'capistrano', '~> 3.16'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm'
end

group :development do
  gem 'web-console'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
end
