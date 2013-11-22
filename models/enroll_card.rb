# == Schema Information
#
# Table name: enroll_cards
#
#  id           :integer          not null, primary key
#  pin          :string           not null
#  payment_type :integer          default(1), not null
#  balance      :decimal(9, 4)    default(0.0), not null
#  card_type_id :integer          not null
#  user_id      :integer          not null
#

# -*- encoding : utf-8 -*-
class EnrollCard < ActiveRecord::Base
	belongs_to :card_type
	belongs_to :user, foreign_key: 'user_id', class_name: 'EnrollUser'

	def to_s
		pin	
	end
end
