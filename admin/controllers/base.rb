# -*- encoding : utf-8 -*-
Estacionamento::Admin.controllers :base do
  get :index, :map => "/" do
  	@histories = ParkingHistory.joins(:card).select('parking_histories.*, enroll_cards.pin')
    render "base/index"
  end
end
