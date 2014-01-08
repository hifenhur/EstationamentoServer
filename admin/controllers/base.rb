# -*- encoding : utf-8 -*-
Estacionamento::Admin.controllers :base do
  get :index, :map => "/" do
  	@day_card_type2 =Payment.use_by_type_and_period :day, 2
	@day_card_type1 =Payment.use_by_type_and_period :day, 1
	@week_card_type2 =Payment.use_by_type_and_period :week, 2
	@week_card_type1 =Payment.use_by_type_and_period :week, 1
	@month_card_type2 =Payment.use_by_type_and_period :month, 2
	@month_card_type1 =Payment.use_by_type_and_period :month, 1
  	@day_trade = Payment.trade_by_period(:day)
	@week_trade = Payment.trade_by_period(:week)
	@month_trade = Payment.trade_by_period(:month)
	@day_use = Payment.movements_by_period :day
	@week_use = Payment.movements_by_period :week
	@month_use = Payment.movements_by_period :month
	if params[:popup] == 'true'
		@histories = Payment.order('dt_checkin desc')
	else
		@histories = Payment.order('dt_checkin desc').paginate(page: params[:page], per_page: 11)
	end
  	
  	
    render "base/index"
  end

  get :index, :map => "/datefilter" do
  	@dt_checkin_gt = params[:dt_checkin_gt].to_date.at_beginning_of_day
  	@dt_checkin_lt = params[:dt_checkin_lt].to_date.tomorrow.at_beginning_of_day
  	@search = Payment.search_by_query(dt_checkin_gt: @dt_checkin_gt, dt_checkin_lt: @dt_checkin_lt)
	@history = @search[:history]
	@amount = @search[:amount]
	@movement = @search[:movement]
	@m_card = @search[:m_card]
	@nm_card = @search[:nm_card]
	
  	render "base/filtered_data", :layout => 'without_header'
  end
end
