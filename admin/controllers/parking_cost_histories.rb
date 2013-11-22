Estacionamento::Admin.controllers :parking_cost_histories do
  get :index do
    @title = "Parking_cost_histories"
    @parking_cost_histories = ParkingCostHistory.all
    render 'parking_cost_histories/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'parking_cost_history')
    @parking_cost_history = ParkingCostHistory.new
    render 'parking_cost_histories/new'
  end

  post :create do
    @parking_cost_history = ParkingCostHistory.new(params[:parking_cost_history])
    if @parking_cost_history.save
      @title = pat(:create_title, :model => "parking_cost_history #{@parking_cost_history.id}")
      flash[:success] = pat(:create_success, :model => 'ParkingCostHistory')
      params[:save_and_continue] ? redirect(url(:parking_cost_histories, :index)) : redirect(url(:parking_cost_histories, :edit, :id => @parking_cost_history.id))
    else
      @title = pat(:create_title, :model => 'parking_cost_history')
      flash.now[:error] = pat(:create_error, :model => 'parking_cost_history')
      render 'parking_cost_histories/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "parking_cost_history #{params[:id]}")
    @parking_cost_history = ParkingCostHistory.find(params[:id])
    if @parking_cost_history
      render 'parking_cost_histories/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'parking_cost_history', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "parking_cost_history #{params[:id]}")
    @parking_cost_history = ParkingCostHistory.find(params[:id])
    if @parking_cost_history
      if @parking_cost_history.update_attributes(params[:parking_cost_history])
        flash[:success] = pat(:update_success, :model => 'Parking_cost_history', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:parking_cost_histories, :index)) :
          redirect(url(:parking_cost_histories, :edit, :id => @parking_cost_history.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'parking_cost_history')
        render 'parking_cost_histories/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'parking_cost_history', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Parking_cost_histories"
    parking_cost_history = ParkingCostHistory.find(params[:id])
    if parking_cost_history
      if parking_cost_history.destroy
        flash[:success] = pat(:delete_success, :model => 'Parking_cost_history', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'parking_cost_history')
      end
      redirect url(:parking_cost_histories, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'parking_cost_history', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Parking_cost_histories"
    unless params[:parking_cost_history_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'parking_cost_history')
      redirect(url(:parking_cost_histories, :index))
    end
    ids = params[:parking_cost_history_ids].split(',').map(&:strip)
    parking_cost_histories = ParkingCostHistory.find(ids)
    
    if ParkingCostHistory.destroy parking_cost_histories
    
      flash[:success] = pat(:destroy_many_success, :model => 'Parking_cost_histories', :ids => "#{ids.to_sentence}")
    end
    redirect url(:parking_cost_histories, :index)
  end
end
