class TasksController < ApplicationController

  get "/tasks" do
    erb :"/tasks/index"
  end

  get "/days/:id/tasks/new" do
    @day = Day.find_by_id(params[:id])
    erb :"/tasks/create_task"
  end

  get "/days/:id/tasks/:taskid/edit" do
    @task = Task.find_by_id(params[:taskid])
    erb :"/tasks/edit_task"
  end

  post "/days/:id/tasks" do
    Task.create(content: params[:content], day_id: params[:id])
    redirect "/days/#{params[:id]}"
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
