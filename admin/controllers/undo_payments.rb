Estacionamento::Admin.controllers :undo_payments do
  get :index do
    @title = "Undo_payments"
    @undo_payments = UndoPayment.all
    render 'undo_payments/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'undo_payment')
    @undo_payment = UndoPayment.new
    render 'undo_payments/new'
  end

  post :create do
    @undo_payment = UndoPayment.new(params[:undo_payment])
    if @undo_payment.save
      @title = pat(:create_title, :model => "undo_payment #{@undo_payment.id}")
      flash[:success] = pat(:create_success, :model => 'UndoPayment')
      params[:save_and_continue] ? redirect(url(:undo_payments, :index)) : redirect(url(:undo_payments, :edit, :id => @undo_payment.id))
    else
      @title = pat(:create_title, :model => 'undo_payment')
      flash.now[:error] = pat(:create_error, :model => 'undo_payment')
      render 'undo_payments/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "undo_payment #{params[:id]}")
    @undo_payment = UndoPayment.find(params[:id])
    if @undo_payment
      render 'undo_payments/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'undo_payment', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "undo_payment #{params[:id]}")
    @undo_payment = UndoPayment.find(params[:id])
    if @undo_payment
      if @undo_payment.update_attributes(params[:undo_payment])
        flash[:success] = pat(:update_success, :model => 'Undo_payment', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:undo_payments, :index)) :
          redirect(url(:undo_payments, :edit, :id => @undo_payment.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'undo_payment')
        render 'undo_payments/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'undo_payment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Undo_payments"
    undo_payment = UndoPayment.find(params[:id])
    if undo_payment
      if undo_payment.destroy
        flash[:success] = pat(:delete_success, :model => 'Undo_payment', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'undo_payment')
      end
      redirect url(:undo_payments, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'undo_payment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Undo_payments"
    unless params[:undo_payment_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'undo_payment')
      redirect(url(:undo_payments, :index))
    end
    ids = params[:undo_payment_ids].split(',').map(&:strip)
    undo_payments = UndoPayment.find(ids)
    
    if UndoPayment.destroy undo_payments
    
      flash[:success] = pat(:destroy_many_success, :model => 'Undo_payments', :ids => "#{ids.to_sentence}")
    end
    redirect url(:undo_payments, :index)
  end
end
