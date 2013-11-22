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

	def to_s
		id	
	end
end
