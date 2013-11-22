# -*- encoding : utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class EnrollUserTest < Test::Unit::TestCase
  context "EnrollUser Model" do
    should 'construct new instance' do
      @enroll_user = EnrollUser.new
      assert_not_nil @enroll_user
    end
  end
end
