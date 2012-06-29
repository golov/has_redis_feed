require 'rspec'
require_relative '../lib/has_redis_feed.rb'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end