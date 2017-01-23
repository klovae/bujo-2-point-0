class TasksController < ApplicationController

  get "/tasks" do
    erb :"/tasks/index"
  end

  get "/days/:id/tasks/new" do
    @day = Day.find_by_id(params[:id])
    erb :"/tasks/create_task"
  end

  post "/days/:id/tasks" do
    day = Day.find_by_id(params[:id])
    Task.create(content: params[:content], day_id: day.id, user_id: day.user_id)
    redirect "/days/#{day.id}"
  end

  patch "/days/:id/tasks" do
    @task = Task.find_by_id(params[:taskid])
    redirect "/tasks/:id"
  end

  # Delete Item Controller
  delete "/days/:id/tasks/:taskid/delete" do
    @task = Task.find_by_id(params[:taskid])
    redirect "/tasks"
  end

end
