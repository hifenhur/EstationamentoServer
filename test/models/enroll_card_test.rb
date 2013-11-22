# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class EnrollCardTest < Test::Unit::TestCase
  context "EnrollCard Model" do
    should 'construct new instance' do
      @enroll_card = EnrollCard.new
      assert_not_nil @enroll_card
    end
  end
end
