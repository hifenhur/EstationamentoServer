# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CardTypeTest < Test::Unit::TestCase
  context "CardType Model" do
    should 'construct new instance' do
      @card_type = CardType.new
      assert_not_nil @card_type
    end
  end
end
