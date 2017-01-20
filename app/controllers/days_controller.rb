class DaysController < ApplicationController

  get "/days" do
    @days = current_user.days.all
    erb :"/days/index"
  end

  get "/days/today" do
    redirect to "/days/#{Day.find_or_create_by(date: Date.today, user_id: current_user).id}"
  end

  get "/days/tomorrow" do
    redirect to "/days/#{Day.find_or_create_by(date: Date.tomorrow, user_id: current_user).id}"
  end

  get "/days/:id" do
    @day = Day.find_by_id(params[:id])
    erb :"/days/show"
  end


end
