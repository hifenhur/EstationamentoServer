Estacionamento::Admin.controllers :parking_histories do
  get :index do
    @title = "Parking_histories"
    @parking_histories = ParkingHistory.paginate(page: params[:page], per_page: 10)
    render 'parking_histories/index'
  end
end
