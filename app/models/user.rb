class User < ActiveRecord::Base
  rolify
  has_many :courses
  has_many :enrollments
  has_many :cohorts, through: :enrollments
  has_many :submissions
  has_many :comments
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

end
