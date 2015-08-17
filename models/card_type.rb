# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: card_types
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  parking_cost :decimal(16, 14)  default(0.0), not null
#

class CardType < ActiveRecord::Base
	has_many :enroll_cards
	has_many :parking_cost_histories

	validates_presence_of :name, :parking_cost
	

	def to_s
		name	
	end
end
