class DaysController < ApplicationController

  get "/days" do
    @days = current_user.days.all
    erb :"/days/index"
  end

  get "/days/today" do
    redirect to "/days/#{Day.find_or_create_by(date: Date.today, user: current_user).id}"
  end

  get "/days/tomorrow" do
    redirect to "/days/#{Day.find_or_create_by(date: Date.tomorrow, user: current_user).id}"
  end

  get "/days/:id" do
    @day = Day.find_by_id(params[:id])
    erb :"/days/show"
  end

  get "/days/:id/previous" do
    current_day = Day.find_by_id(params[:id])
    previous_day = Day.where("date < ? AND user_id = ?", current_day.date, current_user.id)[-2]
    if previous_day
      redirect "/days/#{previous_day.id}"
    else
      flash[:error] = "This is the earliest date in your BuJo 2.0 account"
      redirect "/days/#{current_day.id}"
    end
  end

  get "/days/:id/next" do
    current_day = Day.find_by_id(params[:id])
    next_day = Day.where("date > ? AND user_id = ?", current_day.date, current_user.id).first
    if next_day
      redirect "/days/#{next_day.id}"
    else
      flash[:error] = "BuJo 2.0 does not have a task list for the next day."
      redirect "/days/#{current_day.id}"
    end
  end



end
