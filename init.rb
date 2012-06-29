$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'has_redis_feed'
ActiveRecord::Base.class_eval { include HasRedisFeed }