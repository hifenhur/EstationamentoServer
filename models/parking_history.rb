# == Schema Information
#
# Table name: parking_histories
#
#  id                  :integer          not null, primary key
#  date_time_reg       :datetime
#  card_id             :integer          not null
#  dt_time_in          :datetime         not null
#  dt_time_out         :datetime
#  parkingmeter_id_in  :integer
#  parkingmeter_id_out :integer
#

# -*- encoding : utf-8 -*-
class ParkingHistory < ActiveRecord::Base
	belongs_to :card, foreign_key: 'card_id', class_name: 'EnrollCard'
	has_one :card_type, through: :card
	def to_s
		id	
	end

	def utilized_time_in_hours
 
        @timeElapsed = self.utilized_time.to_i
     
        #find the seconds
        seconds = @timeElapsed % 60
     
        #find the minutes
        minutes = (@timeElapsed / 60) % 60
     
        #find the hours
        hours = (@timeElapsed/3600)
     
        #format the time
     
		return hours.to_s + ":" + format("%02d",minutes.to_s) + ":" + format("%02d",seconds.to_s)
	end

	

	def utilized_time
		dt_time_out - dt_time_in
	end

	def self.get_period(period)
		case period
		when :day
			period = Time.now.at_beginning_of_day
		when :week
			period = 7.days.ago.at_beginning_of_day
		when :month		
			period = 30.days.ago.at_beginning_of_day
		else
			begin
				
			rescue Exception => e
				return e	
			end
		end
		return period
	end

	def self.trade_by_period(period)
		period = get_period(period)
		total = 0
		self.where('dt_time_in > ?', period).includes(:card_type).each do |h|
   			total += (h.utilized_time.to_i * h.card_type.parking_cost)
		end
		return total/100
	end

	def self.use_by_type_and_period(period, type)
		period = get_period(period)
		self.where('dt_time_in > ? and enroll_cards.payment_type = ?', period, type).includes(:card).count
	end

	def self.movements_by_period(period)
		period = get_period(period)
		self.where('dt_time_in > ?', period).count
	end

	

end
