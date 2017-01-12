class TasksController < ApplicationController

  get "/tasks" do
    erb :"/tasks/index"
  end

  get "/tasks/:id" do
    @task = Task.find_by_id(params[:id])
    erb :"/tasks/show"
  end

  get "/tasks/:id/edit" do
    @task = Task.find_by_id(params[:id])
    erb :"/tasks/edit"
  end

  patch "/tasks" do
    @task = Task.find_by_id(params[:id])
    redirect "/tasks/:id"
  end

  # Delete Item Controller
  delete "/tasks/:id/delete" do
    @task = Task.find_by_id(params[:id])
    redirect "/tasks"
  end

end
