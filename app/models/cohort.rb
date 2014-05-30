class Cohort < ActiveRecord::Base
  belongs_to :course
  has_many :enrollments
  has_many :users, through: :enrollments
  belongs_to :location
  has_many :assignments
end