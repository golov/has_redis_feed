HasRedisFeed
========

HasRedisFeed is a simple way of setting and getting feeds for your ActiveRecord objects.

Prerequisites
----------

HasRedisFeed assumes that you have Redis connected to the $redis global variable.

Usage
-----
Add to feed

```ruby
user = User.create
user.push_to_feed({:message => 'old message'})
user.push_to_feed({:message => 'new message'})
user.feed 
# => [{"message"=>"new message"}, {"message"=>"old message"}] 
```

The feed will be created with namespace

    feed:class.name:id

So in this case (with user id 1):

    feed:#{class.name}:#{id}