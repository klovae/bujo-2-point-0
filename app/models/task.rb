class Task < ActiveRecord::Base
  belongs_to :day
  belongs_to :user
  has_many :migrations

  validates :content, :presence => true
end
