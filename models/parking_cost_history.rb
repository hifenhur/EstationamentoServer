# == Schema Information
#
# Table name: parking_cost_histories
#
#  id           :integer          not null, primary key
#  date         :datetime         not null
#  parking_cost :decimal(16, 14)  not null
#  card_type_id :integer          not null
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class ParkingCostHistory < ActiveRecord::Base
	belongs_to :card_type

	def to_s
		parking_cost.round(2)	
	end
end
