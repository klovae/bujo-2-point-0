class SessionsController < ApplicationController

  get '/login' do
    if !is_logged_in?
      erb :'/users/login'
    else
      flash[:success] = "Welcome back, #{current_user.first_name}!"
      redirect '/days/today'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login successful. Welcome, #{current_user.first_name}!"
      redirect '/days/today'
    else
      flash[:error] = "Sorry, your username and/or password is incorrect. Please try again."
      redirect '/login'
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
