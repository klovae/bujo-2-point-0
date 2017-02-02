class Migration < ActiveRecord::Base
  belongs_to :task
  belongs_to :day
end
