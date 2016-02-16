# encoding: utf-8
ruby '2.2.3'
source 'https://rubygems.org'

gem 'rails', '4.2.0.rc2'
gem 'sass-rails', '~> 4.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'angularjs-rails', '~> 1.3.14'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'pg'
gem 'bootstrap-sass', '~> 3.3.1.0'
gem 'responders'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem "cancan"
gem 'pry'
gem 'httparty'
gem "paperclip"
gem "paperclip-dropbox", ">= 1.1.7"
gem "rest-client"
gem "friendly_id"
gem "redcarpet"
gem 'actionpack-page_caching'

group :development do
  gem 'populator'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false

  gem 'terminal-notifier-guard'
end

group :development, :test do
  gem 'faker'
  gem 'spring'
  gem 'web-console', '~> 2.0'
  gem 'byebug',         '4.0.0'
  gem 'pry-byebug',     '3.1.0'

  gem 'better_errors'
end

group :test do
  gem 'guard-minitest',     '2.3.1'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'simplecov'
end


#group :production do
#  gem 'rails_12factor'
#  gem 'puma', '2.11.1'
#end
