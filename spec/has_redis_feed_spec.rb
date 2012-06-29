require 'spec_helper'
require 'active_record'
require 'support/active_record'
require 'support/dummy_model'

describe HasRedisFeed do
  before(:each) do
    @dummy_model = DummyModel.create
  end

  it 'should say hi' do
    @dummy_model.hi.should == "hi"
  end
end