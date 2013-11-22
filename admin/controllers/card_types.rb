Estacionamento::Admin.controllers :card_types do
  get :index do
    @title = "Card_types"
    @card_types = CardType.all
    render 'card_types/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'card_type')
    @card_type = CardType.new
    render 'card_types/new'
  end

  post :create do
    @card_type = CardType.new(params[:card_type])
    if @card_type.save
      @title = pat(:create_title, :model => "card_type #{@card_type.id}")
      flash[:success] = pat(:create_success, :model => 'CardType')
      params[:save_and_continue] ? redirect(url(:card_types, :index)) : redirect(url(:card_types, :edit, :id => @card_type.id))
    else
      @title = pat(:create_title, :model => 'card_type')
      flash.now[:error] = pat(:create_error, :model => 'card_type')
      render 'card_types/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "card_type #{params[:id]}")
    @card_type = CardType.find(params[:id])
    if @card_type
      render 'card_types/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'card_type', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "card_type #{params[:id]}")
    @card_type = CardType.find(params[:id])
    if @card_type
      if @card_type.update_attributes(params[:card_type])
        flash[:success] = pat(:update_success, :model => 'Card_type', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:card_types, :index)) :
          redirect(url(:card_types, :edit, :id => @card_type.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'card_type')
        render 'card_types/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'card_type', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Card_types"
    card_type = CardType.find(params[:id])
    if card_type
      if card_type.destroy
        flash[:success] = pat(:delete_success, :model => 'Card_type', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'card_type')
      end
      redirect url(:card_types, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'card_type', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Card_types"
    unless params[:card_type_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'card_type')
      redirect(url(:card_types, :index))
    end
    ids = params[:card_type_ids].split(',').map(&:strip)
    card_types = CardType.find(ids)
    
    if CardType.destroy card_types
    
      flash[:success] = pat(:destroy_many_success, :model => 'Card_types', :ids => "#{ids.to_sentence}")
    end
    redirect url(:card_types, :index)
  end
end
