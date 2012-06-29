require 'spec_helper'
require 'active_record'
require 'support/active_record'
require 'support/redis'
require 'support/dummy_model'

describe DummyModel do
  before(:each) do
    @dummy_model = DummyModel.create
  end

  it 'should have a key namespaced by the class name' do
    @dummy_model.feed_key.should == "feed:DummyModel:#{@dummy_model.id}"
  end

  it 'should be able to push to its feed and retrieve the feed' do
    @dummy_model.push_to_feed({'alphonso' => 'quigley'})
    @dummy_model.feed.should == [{'alphonso' => 'quigley'}]
  end

  it 'should return the feed in descending created_at order' do
    @dummy_model.stub(:feed_timestamp).and_return(1)
    @dummy_model.push_to_feed({'alphonso' => 'old'})
    @dummy_model.stub(:feed_timestamp).and_return(2)
    @dummy_model.push_to_feed({'alphonso' => 'new'})
    @dummy_model.feed.should == [{'alphonso' => 'new'}, {'alphonso' => 'old'}]
  end

  it 'should return the default of 5 items in the feed' do
    (1..10).each {|i| 
      @dummy_model.stub(:feed_timestamp).and_return(i)
      @dummy_model.push_to_feed({'a' => 'q' + i.to_s})
    }
    @dummy_model.feed.should == [{"a"=>"q10"}, {"a"=>"q9"}, {"a"=>"q8"}, {"a"=>"q7"}, {"a"=>"q6"}]
  end

  it 'should return the correct count' do
    (1..10).each {|i| 
      @dummy_model.stub(:feed_timestamp).and_return(i)
      @dummy_model.push_to_feed({'a' => 'q' + i.to_s})
    }
    @dummy_model.feed(1).should == [{"a"=>"q10"}, {"a"=>"q9"}]
  end

  it 'should encode hash' do @dummy_model.encode({alphonso: 'quigley'}).should == "{\"alphonso\":\"quigley\"}" end

  it 'should decode hash' do 
    original_h = {'alphonso' => 'quigley'}
    h = @dummy_model.encode(original_h)
    @dummy_model.decode(h).should == original_h
  end  
end