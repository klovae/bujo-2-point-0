# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app

Sinatra is what makes it possible to create routes for this app. The main Application Controller (and by inheritance, all the other controllers) is a Sinatra controller because as a class it inherits from Sinatra::Base, which allows the controller to make use of Sinatra's HTTP methods like `get` and `post` to communicate between the user and the app.

- [x] Use ActiveRecord for storing information in a database

ActiveRecord is super important to this app. All the CRUD functionality for all of the models is possible because of ActiveRecord, as well as the relationships between objects, as defined with `has_many`, `has_many, through:`, and `belongs_to`. Without ActiveRecord, all CRUD interactions with the database would have needed to be done manually (as in pre-ActiverRecord labs).

- [x] Include more than one model class (list of model class names e.g. User, Post, Category)

Models:
* User
* Day
* Task
* Event
* Migration

- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)

* User `has_many` days, `has_many` tasks and events through days, and `has_many` migrations through tasks and days
* Day `has_many` tasks, events, and migrations
* Task `has_many` migrations

- [x] Include user accounts

User creates an account that gives them access to their "own" bullet journal -- they are the only ones who can see or modify their days, tasks, and events. In the case of this app, I used email as the username because there wasn't really a need for separate usernames because no users are seeing each others' content.

- [x] Ensure that users can't modify content created by other users

All CRUD functionality in the routes for this app either (1) explicitly checks that the desired information belongs only to the current user or (2) implicitly pulls for display information only from the current user. You can see this in my DaysController.

Example of (1):
```
 get "/days/:id" do
    @day = Day.find_by_id(params[:id])
    if is_logged_in? && @day.user == current_user
      erb :"/days/show"
    else
      flash[:error] = "You must be logged in as a different user to view that task list"
      redirect '/'
    end
  end
```
Example of (2)
```
get "/days" do
    @days = current_user.days.all
    erb :"/days/index"
  end
```

- [x] Include user input validations

All points of user input include validations. Some of them are embedded in my models like with the User model:
```
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
```
Or the inputs are checked on form submission. For example, a user can't create a task without a description, and also can't update a task to remove a description.
```
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
```

- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)

All points where user input is validated also come with error messages that specify what is raising the error. Probably the most thorough error messages can be found in the `post '/signup'` route:
```
  post '/signup' do
    if params.none? {|key, value| value == ""}
      if User.find_by(email: params[:email]).nil? && params[:password] == params[:password_check]
        user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
        session[:user_id] = user.id
        flash[:success] = "Account created successfully. Welcome to BuJo 2.0!"
        redirect '/days/today'
      elsif User.find_by(email: params[:email]) && params[:password] == params[:password_check]
        flash[:error] = "There is already a user associated with that email address."
        redirect '/signup'
      elsif params[:password] != params[:password_check]
        flash[:error] = "Your password entries don't match."
        redirect '/signup'
      end
    else
      flash[:error] = "Please make sure you have completed all fields before creating your account."
      redirect '/signup'
    end
  end
```  

- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

All requirements have been added, and the license for my code has also been included in the root directory.

Confirm
- [x] You have a large number of small Git commits

As of the time of submission, I will have made over 45 commits to this repo. That said, I think I got a lot better about committing regularly as time went on. Early in the process there were a couple of time where I got caught up in coding and forgot to commit more regularly. In the future I think I may look into setting (or creating) some kind of alarm. Might be a nice feature to have in Atom.

- [x] Your commit messages are meaningful

If anything I think I may have been overly descriptive sometimes, but I did work to make sure they reflected the work I did and the relevant file(s) I worked on.

- [x] You made the changes in a commit that relate to the commit message

Yes; as above, I made sure in all cases that the message related to what I worked on.

- [x] You don't include changes in a commit that aren't related to the commit message

I did a good job with this for the most part but I honestly could have done better, especially in the beginning of the project where it was too easy to do a bunch of work and realize belatedly that it had been a while since I committed. Definitely something I will be more conscious of when starting future projects.
