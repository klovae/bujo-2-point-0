class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "keep_track_of_all_your_stuff"
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?(session)
      session.has_key?(:user_id)
    end
  end

  #Index Controller
  get "/" do
    erb :index
  end

end
