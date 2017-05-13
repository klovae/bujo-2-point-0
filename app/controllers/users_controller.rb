class UsersController < ApplicationController

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
    if params[:password]
      if params[:password] != "" && params[:password] == params[:password_check]
        current_user.update(password: params[:password])
        flash[:success] = "Password updated successfully."
        redirect '/days/today'
      elsif params[:password] != "" && params[:password] != params[:password_check]
        flash[:error] = "Your new password entries don't match."
        redirect '/settings'
      end

    elsif params[:email] != "" && params[:first_name] != "" && params[:last_name] != ""
      if User.find_by(email: params[:email]) == current_user || User.find_by(email: params[:email]).nil?
        current_user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
        flash[:success] = "Account settings updated successfully."
        redirect '/days/today'
      else
        flash[:error] = "That email address is already in use."
        redirect '/settings'
      end
    else
      flash[:error] = "Please make sure you have completed all fields before updating your account."
      redirect '/settings'
    end
  end

  get '/signup' do
    if !is_logged_in?
      erb :'/users/create_user'
    else
      flash[:success] = "You're already logged in as #{current_user.first_name}"
      redirect '/days/today'
    end
  end

  post '/signup' do
    @user = User.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
    if !@user.id.nil?
      session[:user_id] = @user.id
      flash[:success] = "Account created successfully. Welcome to BuJo 2.0!"
      redirect '/days/today'
    else
      error_messages = []
      @user.errors.messages.each {|key, value| error_messages << value.flatten}
      flash[:error] = error_messages
      redirect '/signup'
    end
  end

end
