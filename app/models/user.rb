class User < ActiveRecord::Base
  has_many :days
  has_many :tasks, through: :days
  has_many :events, through: :days
  has_secure_password

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
end
