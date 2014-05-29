class User < ActiveRecord::Base
  has_many :assignments, through: :assignment_queue
  has_many :courses
  has_many :cohorts, through: :enrollment
  has_many :submissions
  #has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable



end
