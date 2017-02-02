
class EventsController < ApplicationController

  get "/days/:id/events/new" do
    @day = Day.find_by_id(params[:id])
    erb :"/events/create_event"
  end

  post "/days/:id/events" do
    day = Day.find_by_id(params[:id])
    if Event.create(content: params[:content], day_id: day.id, user_id: day.user_id).valid?
      flash[:success] = "Event added."
      redirect "/days/#{day.id}"
    else
      flash[:error] = "Events need a description to be added to your bullet journal."
      redirect "/days/#{day.id}/events/new"
    end
  end

  get "/events/:eventid" do
    @event = Event.find_by_id(params[:eventid])
    erb :"/events/edit_event"
  end

  patch "/events/:eventid" do
    @event = Event.find_by_id(params[:eventid])
    if params[:content] != ""
      @event.update(content: params[:content])
      flash[:success] = "Event updated successfully!"
      redirect "/days/#{@event.day_id}"
    else
      flash[:error] = "Please add the description for your event to update it."
      redirect "/events/#{@event.id}"
    end
  end

  delete "/events/:eventid/delete" do
    event = Event.find_by_id(params[:eventid])
    day_id = event.day.id
    event.delete
    redirect "/days/#{day_id}"
  end

end
