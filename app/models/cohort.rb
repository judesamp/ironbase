class Cohort < ActiveRecord::Base
  belongs_to :course
  has_many :enrollments
  has_many :users, through: :enrollments
  belongs_to :location
  has_many :assignments

  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :course
  validates_presence_of :location
end