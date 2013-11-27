# -*- encoding : utf-8 -*-
Estacionamento::Admin.controllers :parking_cost_histories do
  get :index do
    @title = "Parking_cost_histories"
    @parking_cost_histories = ParkingCostHistory.paginate(page: params[:page], per_page: 10)
    render 'parking_cost_histories/index'
  end

  
end
