class User < ActiveRecord::Base
  has_many :days
  has_many :tasks, through: :days
  has_many :events, through: :days
  has_many :migrations, through: :tasks
  has_secure_password validations: false

  validates :email, uniqueness: { message: "There is already a user associated with that email address"}, on: [:create, :update_info]
  validates :password, confirmation: { message: "Both passwords must match"}, on: [:create, :update_password]
  validates :first_name, :email, :last_name, presence: { message: "All fields must be filled out" }, on: [:create, :update_info]
  validates :password, :password_confirmation, presence: { message: "All fields must be filled out" }, on: [:create, :update_password]
end
