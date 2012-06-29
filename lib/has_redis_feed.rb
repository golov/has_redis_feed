$:.unshift "#{File.dirname(__FILE__)}/lib"
require "active_record"
require "redis"

module HasRedisFeed
  FEED_COUNT = 4

  def feed(count=FEED_COUNT)
    encoded_result = $redis.zrevrange feed_key, 0, count
    if encoded_result and encoded_result.size > 0
      encoded_result.map { |r| self.decode(r) }
    else
      encoded_result
    end
  end

  def push_to_feed(h)
    encoded_h = self.encode(h)
    $redis.zadd feed_key, feed_timestamp, encoded_h
  end

  def feed_timestamp
    "#{DateTime.now.to_i}"
  end  

  def feed_key
    "feed:#{self.class.to_s}:#{self.id}"
  end

  def encode(obj)
    obj.to_json
  end

  def decode(json)
    ActiveSupport::JSON.decode(json)
  end
end

ActiveRecord::Base.class_eval { include HasRedisFeed }