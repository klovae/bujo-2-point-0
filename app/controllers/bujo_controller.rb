class BujosController < ApplicationController

  #Index Controller
  get "/bujos" do
    erb :"/bujos/index.html"
  end

  # New Item Controllers
  get "/bujos/new" do
    erb :"/bujos/new.html"
  end

  post "/bujos" do
    redirect "/bujos"
  end

  # Show Item Controller
  get "/bujos/:id" do
    erb :"/bujos/show.html"
  end

  # Edit Item Controller
  get "/bujos/:id/edit" do
    erb :"/bujos/edit.html"
  end

  patch "/bujos" do
    redirect "/bujos/:id"
  end

  # Delete Item Controller
  delete "/bujos/:id/delete" do
    redirect "/bujos"
  end
end
