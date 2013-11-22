require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ParameterTest < Test::Unit::TestCase
  context "Parameter Model" do
    should 'construct new instance' do
      @parameter = Parameter.new
      assert_not_nil @parameter
    end
  end
end
