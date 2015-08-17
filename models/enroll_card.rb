# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: enroll_cards
#
#  id           :integer          not null, primary key
#  pin          :text             not null
#  balance      :decimal(9, 4)    default(0.0), not null
#  card_type_id :integer
#  user_id      :integer
#

class EnrollCard < ActiveRecord::Base
	table_name = "card"
	belongs_to :card_type
	belongs_to :user, foreign_key: 'user_id', class_name: 'EnrollUser'

	validates_presence_of :pin, :payment_type, :balance, :card_type_id, :user_id
	
	def to_s
		pin	
	end
end
