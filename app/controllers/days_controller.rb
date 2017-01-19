class DaysController < ApplicationController

  get "/days" do
    @days = Day.find_each {|d| d.user_id == current_user.id}
    erb :"/days/index"
  end

  get "/days/today" do
    today = Day.where(date: Date.today, user_id: current_user)
    if today
      date = today
    else
      date = Day.create(date: Date.today, user_id: current_user)
    end
    redirect to "/days/#{date.id}"
  end

  get "/days/tomorrow" do
    tomorrow = Day.where(date: Date.tomorrow, user_id: current_user)
    if tomorrow
      date = tomorrow
    else
      date = Day.create(date: Date.tomorrow, user_id: current_user)
    end
    redirect to "/days/#{date.id}"
  end

  get "/days/:id" do
    @day = Day.find_by_id(params[:id])
    erb :"/days/show"
  end



end
