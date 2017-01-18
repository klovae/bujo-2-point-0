class UsersController < ApplicationController

  get '/login' do
    if !is_logged_in?(session)
      erb :'/users/login'
    else
      redirect '/home'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    else
      flash[:error] = "Sorry, your username and/or password is incorrect. Please try again."
      redirect '/login'
    end
  end

  get "/signup" do
    erb :"/users/create_user"
  end

  get '/signup' do
    if !is_logged_in?(session)
      erb :'/users/create_user'
    else
      redirect '/home'
    end
  end

  post '/signup' do
    if params.none? {|key, value| value == ""}
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      flash[:success] = "Account created successfully. Welcome to BuJo 2.0!"
      redirect '/home'
    else
      flash[:error] = "Please make sure you have completed all fields before creating your account."
      redirect '/signup'
    end
  end

  get '/logout' do
    session.clear
    flash[:success] = "Buh-bye now!"
    redirect '/login'
  end


end
