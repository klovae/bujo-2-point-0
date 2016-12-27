class DayController < ApplicationController

  # New Item Controllers
  get "/day/new" do
    erb :"/bujo/new"
  end

  post "/day" do
    redirect "/day"
  end

  # Show Item Controller
  get "/day/:id" do
    erb :"/day/show"
  end

end
