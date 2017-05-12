class User < ActiveRecord::Base
  has_many :days
  has_many :tasks, through: :days
  has_many :events, through: :days
  has_many :migrations, through: :tasks
  has_secure_password

  validates :first_name, :email, :last_name, presence: true
  validates :email, uniqueness: true
end
