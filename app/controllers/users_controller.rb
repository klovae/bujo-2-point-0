class UsersController < ApplicationController

  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      redirect '/home'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login successful!"
      redirect '/home'
    else
      flash[:error] = "Sorry, your username and/or password is incorrect. Please try again."
      redirect '/login'
    end
  end

  get '/settings' do
    if is_logged_in?
      @user = current_user
      erb :'/users/edit_user'
    else
      flash[:error] = "You must be signed in to change your settings"
      redirect '/login'
    end
  end

  patch '/settings' do
    binding.pry
    if params[:password]
      if params[:password] != "" && params[:password] == params[:password_check]
        current_user.update(password: params[:password])
        flash[:success] = "Password updated successfully."
        redirect '/home'
      elsif params[:password] != "" && params[:password] != params[:password_check]
        flash[:error] = "Your new password entries don't match."
        redirect '/settings'
      end

    elsif params[:email] != "" && params[:first_name] != "" && params[:last_name] != ""
      if User.find_by(email: params[:email]) == current_user || User.find_by(email: params[:email]).nil?
        current_user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
        flash[:success] = "Account settings updated successfully."
        redirect '/home'
      else
        flash[:error] = "That email address is already in use."
        redirect '/settings'
      end
    else
      flash[:error] = "Please make sure you have completed all fields before updating your account."
      redirect '/settings'
    end
  end

  get '/home' do
    if is_logged_in?
      erb :'/users/home'
    else
      flash[:error] = "You must be signed in to view your bullet journal"
      redirect '/login'
    end
  end

  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user'
    else
      redirect '/home'
    end
  end

  post '/signup' do
    if params.none? {|key, value| value == ""}
      if User.find_by(email: params[:email]).nil? && params[:password] == params[:password_check]
        user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password], past_migration: true)
        session[:user_id] = user.id
        flash[:success] = "Account created successfully. Welcome to BuJo 2.0!"
        redirect '/home'
      elsif User.find_by(email: params[:email]) && params[:password] == params[:password_check]
        flash[:error] = "There is already a user associated with that email address."
        redirect '/signup'
      elsif params[:password] != params[:password_check]
        flash[:error] = "Your password entries don't match."
        redirect '/signup'
      end
    else
      flash[:error] = "Please make sure you have completed all fields before creating your account."
      redirect '/signup'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      flash[:success] = "Buh-bye now!"
      redirect '/login'
    else
      redirect '/'
    end
  end


end
