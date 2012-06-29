Gem::Specification.new do |s|
  s.name        = 'has_redis_feed'
  s.version     = '0.0.1'
  s.date        = '2012-06-29'
  s.summary     = "Redis Activity Feed"
  s.description = "A simple gem for adding an activity feed to an ActiveRecord object"
  s.authors     = ["Peter Golov"]
  s.email       = 'peter@golov.me'
  s.files       = ["lib/has_redis_feed.rb"]
  s.homepage    = 'https://github.com/golov/has_redis_feed'
  s.test_files  = Dir.glob("{spec,test}/**/*.rb")
  s.add_development_dependency 'rspec', '~> 2.10.0'
end