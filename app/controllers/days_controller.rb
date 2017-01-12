class DaysController < ApplicationController

  # New Item Controllers
  get "/days/new" do
    erb :"/days/new"
  end

  post "/days" do
    redirect "/days"
  end

  # Show Item Controller
  get "/days/:id" do
    erb :"/days/show"
  end

  get "/days" do
    @days = Day.all #where :user_id = current_user.id
    erb :"/days/index"
  end

end
