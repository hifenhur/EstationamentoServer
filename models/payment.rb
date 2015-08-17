# == Schema Information
#
# Table name: payments
#
#  id                :integer          not null, primary key
#  city              :text             not null
#  address           :text             not null
#  diff_hours        :text             not null
#  diff_days         :integer          not null
#  card_number       :text             not null
#  price             :decimal(5, 2)    not null
#  dt_checkin        :datetime
#  dt_checkout       :datetime
#  received_value    :text             not null
#  tolerance         :text
#  id_type_operation :integer
#  dh_ins            :datetime
#

class Payment < ActiveRecord::Base
	
	default_scope ->{where('id not in (?)', UndoPayment.pluck(:id_payment)).order('dt_checkout desc')}
	
	has_many :undo_payments, foreign_key: 'id_payment'

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
		(dt_checkout - dt_checkin) if dt_checkout && dt_checkin
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
		
		total = self.where('dt_checkout > ?', period).sum(:price)
   			
		return total
	end

	def self.use_by_type_and_period(period, type)
		period = get_period(period)
		if type == 1
			self.where('dt_checkout > ? and card_number != ?', period, "Pag. Avulso").count
		else	
			self.where('dt_checkout > ? and card_number = ?', period, "Pag. Avulso").count
		end
		
	end

	def self.movements_by_period(period)
		period = get_period(period)
		self.where('dt_checkout > ?', period).count
	end


	def self.search_by_query(params = {})
		date_filter = if params[:dt_checkout_gt] || params[:dt_checkout_lt]
			if params[:dt_checkout_gt] && params[:dt_checkout_lt]
				"dt_checkout > '#{params[:dt_checkout_gt]}' and dt_checkout < '#{params[:dt_checkout_lt]}'"
			elsif params[:dt_checkout_gt]
			 	"dt_checkout > '#{params[:dt_checkout_gt]}'"
			else
				"dt_checkout < '#{params[:dt_checkout_lt]}'"
			end
		else
			nil
		end
		card_filter = if params[:card_number]
			"card_number = '#{params[:card_number]}'"
		else
			nil
		end

		if !card_filter
			@history = self.where("#{date_filter}")	
		elsif !date_filter
			@history = self.where("#{card_filter}")	
		else
			@history = self.where("#{date_filter} and #{card_filter}")	
		end

		#guardando dados de total utilizado
		@amount = 0

		@history.each do |h|
   			@amount += h.price
		end

		#quantidade de utilizações
		@movement = @history.count

		#quantidade de pagamentos avulsos e mensalistas
		@m_card = @history.select{|h| h.card_number != "Pag. Avulso"}.count
		@nm_card = @history.select{|h| h.card_number == "Pag. Avulso"}.count

		return {history: @history, amount: @amount, movement: @movement, m_card: @m_card, nm_card: @nm_card}


	end
end
