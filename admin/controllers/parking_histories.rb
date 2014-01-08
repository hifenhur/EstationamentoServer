Estacionamento::Admin.controllers :parking_histories do
  get :index do
    @title = "Parking_histories"
    @parking_histories = Payment.order('dt_checkin desc').paginate(page: params[:page], per_page: 11)
    render 'parking_histories/index'
  end
end
