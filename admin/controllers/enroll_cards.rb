Estacionamento::Admin.controllers :enroll_cards do
  get :index do
    @title = "Enroll_cards"
    @enroll_cards = EnrollCard.all
    render 'enroll_cards/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'enroll_card')
    @enroll_card = EnrollCard.new
    render 'enroll_cards/new'
  end

  post :create do
    @enroll_card = EnrollCard.new(params[:enroll_card])
    if @enroll_card.save
      @title = pat(:create_title, :model => "enroll_card #{@enroll_card.id}")
      flash[:success] = pat(:create_success, :model => 'EnrollCard')
      params[:save_and_continue] ? redirect(url(:enroll_cards, :index)) : redirect(url(:enroll_cards, :edit, :id => @enroll_card.id))
    else
      @title = pat(:create_title, :model => 'enroll_card')
      flash.now[:error] = pat(:create_error, :model => 'enroll_card')
      render 'enroll_cards/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "enroll_card #{params[:id]}")
    @enroll_card = EnrollCard.find(params[:id])
    if @enroll_card
      render 'enroll_cards/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'enroll_card', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "enroll_card #{params[:id]}")
    @enroll_card = EnrollCard.find(params[:id])
    if @enroll_card
      if @enroll_card.update_attributes(params[:enroll_card])
        flash[:success] = pat(:update_success, :model => 'Enroll_card', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:enroll_cards, :index)) :
          redirect(url(:enroll_cards, :edit, :id => @enroll_card.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'enroll_card')
        render 'enroll_cards/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'enroll_card', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Enroll_cards"
    enroll_card = EnrollCard.find(params[:id])
    if enroll_card
      if enroll_card.destroy
        flash[:success] = pat(:delete_success, :model => 'Enroll_card', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'enroll_card')
      end
      redirect url(:enroll_cards, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'enroll_card', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Enroll_cards"
    unless params[:enroll_card_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'enroll_card')
      redirect(url(:enroll_cards, :index))
    end
    ids = params[:enroll_card_ids].split(',').map(&:strip)
    enroll_cards = EnrollCard.find(ids)
    
    if EnrollCard.destroy enroll_cards
    
      flash[:success] = pat(:destroy_many_success, :model => 'Enroll_cards', :ids => "#{ids.to_sentence}")
    end
    redirect url(:enroll_cards, :index)
  end
end
