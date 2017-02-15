require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "keep_track_of_all_your_stuff"
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?
      session.has_key?(:user_id)
    end
  end

  get "/" do
    if is_logged_in?
      redirect "/days/today"
    else
      erb :index
    end
  end

  get "/help" do
    erb :help
  end

  get "/about" do
    erb :about
  end

end
