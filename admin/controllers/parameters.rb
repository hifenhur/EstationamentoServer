Estacionamento::Admin.controllers :parameters do
  get :index do
    @title = "Parameters"
    @parameters = Parameter.all
    render 'parameters/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'parameter')
    @parameter = Parameter.new
    render 'parameters/new'
  end

  post :create do
    @parameter = Parameter.new(params[:parameter])
    if @parameter.save
      @title = pat(:create_title, :model => "parameter #{@parameter.id}")
      flash[:success] = pat(:create_success, :model => 'Parameter')
      params[:save_and_continue] ? redirect(url(:parameters, :index)) : redirect(url(:parameters, :edit, :id => @parameter.id))
    else
      @title = pat(:create_title, :model => 'parameter')
      flash.now[:error] = pat(:create_error, :model => 'parameter')
      render 'parameters/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "parameter #{params[:id]}")
    @parameter = Parameter.find(params[:id])
    if @parameter
      render 'parameters/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'parameter', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "parameter #{params[:id]}")
    @parameter = Parameter.find(params[:id])
    if @parameter
      if @parameter.update_attributes(params[:parameter])
        flash[:success] = pat(:update_success, :model => 'Parameter', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:parameters, :index)) :
          redirect(url(:parameters, :edit, :id => @parameter.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'parameter')
        render 'parameters/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'parameter', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Parameters"
    parameter = Parameter.find(params[:id])
    if parameter
      if parameter.destroy
        flash[:success] = pat(:delete_success, :model => 'Parameter', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'parameter')
      end
      redirect url(:parameters, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'parameter', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Parameters"
    unless params[:parameter_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'parameter')
      redirect(url(:parameters, :index))
    end
    ids = params[:parameter_ids].split(',').map(&:strip)
    parameters = Parameter.find(ids)
    
    if Parameter.destroy parameters
    
      flash[:success] = pat(:destroy_many_success, :model => 'Parameters', :ids => "#{ids.to_sentence}")
    end
    redirect url(:parameters, :index)
  end
end
