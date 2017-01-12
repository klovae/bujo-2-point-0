class Task < ActiveRecord::Base
  belongs_to :day

  validates :content, :presence => true
end
