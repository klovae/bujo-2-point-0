class Day < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
  has_many :events
  has_many :migrations
end
