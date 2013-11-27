# -*- encoding : utf-8 -*-
Estacionamento::Admin.controllers :base do
  get :index, :map => "/" do
  	@day_card_type2 =ParkingHistory.use_by_type_and_period :day, 2
	@day_card_type1 =ParkingHistory.use_by_type_and_period :day, 1
	@week_card_type2 =ParkingHistory.use_by_type_and_period :week, 2
	@week_card_type1 =ParkingHistory.use_by_type_and_period :week, 1
	@month_card_type2 =ParkingHistory.use_by_type_and_period :month, 2
	@month_card_type1 =ParkingHistory.use_by_type_and_period :month, 1
  	@day_trade = ParkingHistory.trade_by_period(:day)
	@week_trade = ParkingHistory.trade_by_period(:week)
	@month_trade = ParkingHistory.trade_by_period(:month)
	@day_use = ParkingHistory.movements_by_period :day
	@week_use = ParkingHistory.movements_by_period :week
	@month_use = ParkingHistory.movements_by_period :month
  	@histories = ParkingHistory.joins(:card).select('parking_histories.*, enroll_cards.pin').order(:dt_time_in).paginate(page: params[:page], per_page: 11)
    render "base/index"
  end

  get :index, :map => "/datefilter" do
  	@period = params[:period].to_date
  	@day_card_type2 =ParkingHistory.use_by_type_and_period period, 2
	@day_card_type1 =ParkingHistory.use_by_type_and_period period, 1
	@day_trade = ParkingHistory.trade_by_period period
	@day_use = ParkingHistory.movements_by_period period
  	render "base/filtered_data"
  end
end
