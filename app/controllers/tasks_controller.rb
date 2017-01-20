class TasksController < ApplicationController

  get "/tasks" do
    erb :"/tasks/index"
  end

  get "/days/:id/tasks/new" do
    @day = Day.find_by_id(params[:id])
    erb :"/tasks/create_task"
  end

  get "/days/:id/tasks/:id/edit" do
    @task = Task.find_by_id(params[:id])
    erb :"/tasks/edit_task"
  end

  post "/days/:id/tasks" do
    Task.create(content: params[:content], day_id: params[:id])
    redirect "/days/#{params[:id]}"
  end

  patch "/days/:id/tasks" do
    @task = Task.find_by_id(params[:id])
    redirect "/tasks/:id"
  end

  # Delete Item Controller
  delete "/days/:id/tasks/:id/delete" do
    @task = Task.find_by_id(params[:id])
    redirect "/tasks"
  end

end
