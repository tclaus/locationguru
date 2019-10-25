# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.7'

# git_source(:github) do |repo_name|
#  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#  "https://github.com/#{repo_name}.git"
# end

gem 'dotenv-rails', groups: %i[development test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
gem 'rails-i18n', '~> 5.1'

# Use Postgres as the database for Active Record
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.7'

# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.4.1'
gem 'sassc-rails', '>= 2.1.0'
gem 'font-awesome-sass', '~> 5.0'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~>6.0'

# Photos and avatars
gem 'aws-sdk-s3'
gem 'paperclip', '~> 6.0.0'

# Non Blocking Notifications
gem 'toastr-rails', '~>1.0'

# Auth Tool
gem 'devise', '~>4.7'
gem 'devise-i18n'

# Send emails
gem 'mailgun-ruby' #, git: 'https://github.com/mailgun/mailgun-ruby'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'geocoder'
gem 'ransack'
gem 'simple_calendar', '~> 2.0'
gem 'twilio-ruby'

# Use Queue backend
gem 'resque'
gem 'rufus-scheduler'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  # Rails 12factor
  # Makes running your Rails app easier. Based on the ideas behind 12factor.net
  # Needed for support of Asset Pipeline with Heroku
  # https://github.com/heroku/rails_12factor
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
