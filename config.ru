require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use DaysController
use TasksController
use UsersController
use EventsController
use SessionsController
run ApplicationController
