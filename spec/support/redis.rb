port = 10000
$redis = Redis.new(:host => 'localhost', :port => port)
begin
  $redis.flushall
rescue Errno::ECONNREFUSED
  puts "Redis is not listening in port #{port}. Run:" 
  puts "  redis-server ./spec/support/redis.conf" 
  exit
end