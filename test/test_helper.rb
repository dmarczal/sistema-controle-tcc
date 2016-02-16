ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"

require 'simplecov'
require 'factory_girl'
include FactoryGirl::Syntax::Methods

Minitest::Reporters.use!

class ActiveSupport::TestCase
end
