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

  get '/home' do
    @user = User.find_by_id(session[:user_id])
    erb :'/users/home'
  end



  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user'
    else
      redirect '/home'
    end
  end

  post '/signup' do
    if params.none? {|key, value| value == ""} && User.find_by(email: params[:email]).nil?
      user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:success] = "Account created successfully. Welcome to BuJo 2.0!"
      redirect '/home'
    elsif params.none? {|key, value| value == ""} && User.find_by(email: params[:email])
      flash[:error] = "There is already a user associated with that email address."
      redirect '/signup'
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
