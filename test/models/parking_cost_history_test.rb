require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ParkingCostHistoryTest < Test::Unit::TestCase
  context "ParkingCostHistory Model" do
    should 'construct new instance' do
      @parking_cost_history = ParkingCostHistory.new
      assert_not_nil @parking_cost_history
    end
  end
end
