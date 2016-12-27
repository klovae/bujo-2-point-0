ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
require 'rack-flash'
require_all 'app'
require_all 'lib'
ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  DatabaseCleaner.strategy = :truncation

  config.before ENV["SINATRA_ENV"] = "test"

  require_relative '../config/environment'
  require 'rack/test'
  require 'capybara/rspec'
  require 'capybara/dsl'

  if ActiveRecord::Migrator.needs_migration?
    raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
  end

  ActiveRecord::Base.logger = nil

  RSpec.configure do |config|
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.include Rack::Test::Methods
    config.include Capybara::DSL
    DatabaseCleaner.strategy = :truncation

    config.before do
      DatabaseCleaner.clean
    end

    config.after do
      DatabaseCleaner.clean
    end

    config.order = 'default'
  end

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  Capybara.app = app

    DatabaseCleaner.clean
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
