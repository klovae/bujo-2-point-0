class TaskController < ApplicationController

  # Edit Item Controller
  get "/task/:id/edit" do
    erb :"/task/edit"
  end

  patch "/task" do
    redirect "/task/:id"
  end

  # Delete Item Controller
  delete "/task/:id/delete" do
    redirect "/task"
  end

end
