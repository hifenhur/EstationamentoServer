# -*- encoding : utf-8 -*-
Estacionamento::Admin.controllers :enroll_users do
  get :index do
    @title = "Enroll_users"
    @enroll_users = EnrollUser.paginate(page: params[:page], per_page: 10)
    render 'enroll_users/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'enroll_user')
    @enroll_user = EnrollUser.new
    render 'enroll_users/new'
  end

  post :create do
    @enroll_user = EnrollUser.new(params[:enroll_user])
    if @enroll_user.save
      @title = pat(:create_title, :model => "enroll_user #{@enroll_user.id}")
      flash[:success] = pat(:create_success, :model => 'EnrollUser')
      params[:save_and_continue] ? redirect(url(:enroll_users, :index)) : redirect(url(:enroll_users, :edit, :id => @enroll_user.id))
    else
      @title = pat(:create_title, :model => 'enroll_user')
      flash.now[:error] = pat(:create_error, :model => 'enroll_user')
      render 'enroll_users/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "enroll_user #{params[:id]}")
    @enroll_user = EnrollUser.find(params[:id])
    if @enroll_user
      render 'enroll_users/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'enroll_user', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "enroll_user #{params[:id]}")
    @enroll_user = EnrollUser.find(params[:id])
    if @enroll_user
      if @enroll_user.update_attributes(params[:enroll_user])
        flash[:success] = pat(:update_success, :model => 'Enroll_user', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:enroll_users, :index)) :
          redirect(url(:enroll_users, :edit, :id => @enroll_user.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'enroll_user')
        render 'enroll_users/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'enroll_user', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Enroll_users"
    enroll_user = EnrollUser.find(params[:id])
    if enroll_user
      if enroll_user.destroy
        flash[:success] = pat(:delete_success, :model => 'Enroll_user', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'enroll_user')
      end
      redirect url(:enroll_users, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'enroll_user', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Enroll_users"
    unless params[:enroll_user_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'enroll_user')
      redirect(url(:enroll_users, :index))
    end
    ids = params[:enroll_user_ids].split(',').map(&:strip)
    enroll_users = EnrollUser.find(ids)
    
    if EnrollUser.destroy enroll_users
    
      flash[:success] = pat(:destroy_many_success, :model => 'Enroll_users', :ids => "#{ids.to_sentence}")
    end
    redirect url(:enroll_users, :index)
  end
end
