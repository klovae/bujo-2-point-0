class Task < ActiveRecord::Base
  belongs_to :day
  belongs_to :user

  validates :content, :presence => true
end
