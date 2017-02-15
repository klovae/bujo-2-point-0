class TasksController < ApplicationController

  get "/tasks" do
    @tasks = current_user.tasks.where(["status = ?", "open"])
    erb :"/tasks/index"
  end

  get "/tasks/:taskid" do
    @task = Task.find_by_id(params[:taskid])
    if is_logged_in? && @task.user == current_user
      erb :"/tasks/edit_task"
    else
      flash[:error] = "You must be logged in as a different user to access that task"
      redirect '/'
    end
  end

  patch "/tasks/:taskid" do
    @task = Task.find_by_id(params[:taskid])
    if params[:content] != ""
      @task.update(content: params[:content])
      flash[:success] = "Task updated successfully!"
      redirect "/days/#{@task.day_id}"
    else
      flash[:error] = "Please add the description to your task to update it."
      redirect "/tasks/#{@task.id}"
    end
  end

  patch "/tasks/:taskid/complete" do
    @task = Task.find_by_id(params[:taskid])
    @task.update(status: params[:status])
    flash[:success] = "Hell yeah! Task complete."
    redirect "/days/#{@task.day_id}"
  end

  get "/days/:id/tasks/new" do
    @day = Day.find_by_id(params[:id])
    erb :"/tasks/create_task"
  end

  post "/days/:id/tasks" do
    day = Day.find_by_id(params[:id])
    if Task.create(content: params[:content], day_id: day.id, user_id: day.user_id, status: "open").valid?
      flash[:success] = "Task added."
      redirect "/days/#{day.id}"
    else
      flash[:error] = "Tasks need a description to be added."
      redirect "/days/#{day.id}/tasks/new"
    end
  end

  post "/tasks/:taskid/migrate" do
    task = Task.find_by_id(params[:taskid])
    day_id = task.day.id
    if task.day.date == Date.today
      new_day = Day.find_or_create_by(date: Date.tomorrow, user: current_user)
    else
      new_day = Day.find_or_create_by(date: Date.today, user: current_user)
    end
    migrate = Migration.create(task_id: task.id, day_id: day_id, new_day_id: new_day.id)
    task.day = new_day
    task.save
    flash[:success] = "Task migrated"
    redirect "/days/#{day_id}"
  end

  delete "/tasks/:taskid/delete" do
    task = Task.find_by_id(params[:taskid])
    day_id = task.day.id
    if task.user == current_user && is_logged_in?
      task.delete
      redirect "/days/#{day_id}"
    else
      flash[:error] = "You must be logged in as a different user to access that task"
      redirect '/'
    end
  end

end
