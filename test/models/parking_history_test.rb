# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ParkingHistoryTest < Test::Unit::TestCase
  context "ParkingHistory Model" do
    should 'construct new instance' do
      @parking_history = ParkingHistory.new
      assert_not_nil @parking_history
    end
  end
end
