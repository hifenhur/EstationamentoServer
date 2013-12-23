# == Schema Information
#
# Table name: checkout_payments
#
#  id             :integer          not null, primary key
#  city           :string           not null
#  address        :string           not null
#  diff_hours     :string           not null
#  diff_days      :integer          not null
#  card_number    :string           not null
#  price          :decimal(5, 2)    not null
#  dt_checkin     :datetime         not null
#  dt_checkout    :datetime         not null
#  received_value :string           not null
#  tolerance      :string           not null
#

class Payment < ActiveRecord::Base
	self.table_name = "checkout_payments"
	
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
		dt_checkout - dt_checkin
	end

	def self.get_period(period)
		case period
		when :day
			period = Time.now.at_beginning_of_day
		when :week
			period = Time.now.at_beginning_of_week
		when :month		
			period = Time.now.at_beginning_of_month
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
		self.where('dt_checkin > ?', period).each do |h|
   			total += h.price
		end
		return total
	end

	def self.use_by_type_and_period(period, type)
		period = get_period(period)
		if type == 1
			self.where('dt_checkin > ? and card_number != ?', period, "Pag. Avulso").count
		else	
			self.where('dt_checkin > ? and card_number = ?', period, "Pag. Avulso").count
		end
		
	end

	def self.movements_by_period(period)
		period = get_period(period)
		self.where('dt_checkin > ?', period).count
	end


	def self.search_by_query(params)
		date_filter = if !params[:dt_checkin_gt].empty? || !params[:dt_checkin_lt].empty?
			if !params[:dt_checkin_gt].empty? && !params[:dt_checkin_lt].empty?
				"dt_checkin > '#{params[:dt_checkin_gt]}' and dt_checkin < '#{params[:dt_checkin_lt]}'"
			elsif params[:dt_checkin_gt].empty?
			 	"dt_checkin < '#{params[:dt_checkin_lt]}'"
			else
				"dt_checkin > '#{params[:dt_checkin_gt]}'"
			end
		else
			nil
		end
		card_filter = if !params[:card_number].empty?
			"card_number = '#{params[:card_number]}'"
		else
			nil
		end

		if !card_filter
			self.where("#{date_filter}")	
		elsif !date_filter
			self.where("#{card_filter}")	
		else
			self.where("#{date_filter} and #{card_filter}")	
		end
		
	end
end
