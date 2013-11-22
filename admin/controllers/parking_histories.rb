# -*- encoding : utf-8 -*-
Estacionamento::Admin.controllers :parking_histories do
  get :index do
    @title = "Parking_histories"
    @parking_histories = ParkingHistory.all
    render 'parking_histories/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'parking_history')
    @parking_history = ParkingHistory.new
    render 'parking_histories/new'
  end

  post :create do
    @parking_history = ParkingHistory.new(params[:parking_history])
    if @parking_history.save
      @title = pat(:create_title, :model => "parking_history #{@parking_history.id}")
      flash[:success] = pat(:create_success, :model => 'ParkingHistory')
      params[:save_and_continue] ? redirect(url(:parking_histories, :index)) : redirect(url(:parking_histories, :edit, :id => @parking_history.id))
    else
      @title = pat(:create_title, :model => 'parking_history')
      flash.now[:error] = pat(:create_error, :model => 'parking_history')
      render 'parking_histories/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "parking_history #{params[:id]}")
    @parking_history = ParkingHistory.find(params[:id])
    if @parking_history
      render 'parking_histories/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'parking_history', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "parking_history #{params[:id]}")
    @parking_history = ParkingHistory.find(params[:id])
    if @parking_history
      if @parking_history.update_attributes(params[:parking_history])
        flash[:success] = pat(:update_success, :model => 'Parking_history', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:parking_histories, :index)) :
          redirect(url(:parking_histories, :edit, :id => @parking_history.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'parking_history')
        render 'parking_histories/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'parking_history', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Parking_histories"
    parking_history = ParkingHistory.find(params[:id])
    if parking_history
      if parking_history.destroy
        flash[:success] = pat(:delete_success, :model => 'Parking_history', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'parking_history')
      end
      redirect url(:parking_histories, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'parking_history', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Parking_histories"
    unless params[:parking_history_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'parking_history')
      redirect(url(:parking_histories, :index))
    end
    ids = params[:parking_history_ids].split(',').map(&:strip)
    parking_histories = ParkingHistory.find(ids)
    
    if ParkingHistory.destroy parking_histories
    
      flash[:success] = pat(:destroy_many_success, :model => 'Parking_histories', :ids => "#{ids.to_sentence}")
    end
    redirect url(:parking_histories, :index)
  end
end
