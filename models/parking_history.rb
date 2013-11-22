# == Schema Information
#
# Table name: parking_histories
#
#  id          :integer          not null, primary key
#  dh_ins      :datetime
#  card_id     :integer          not null
#  dt_time_in  :datetime         not null
#  dt_time_out :datetime         not null
#  user_id     :integer
#

# -*- encoding : utf-8 -*-
class ParkingHistory < ActiveRecord::Base
	belongs_to :card, foreign_key: 'card_id', class_name: 'EnrollCard'
	has_one :card_type, through: :card
	def to_s
		id	
	end

	def utilized_time
		dt_time_out - dt_time_in
	end

	def self.day_trade
		total = 0
		self.where('dt_time_in > ?', Time.now.at_beginning_of_day).includes(:card_type).each do |h|
   			total += (h.utilized_time.to_i * h.card_type.parking_cost)
		end
		return total/100
	end


end
