class Cohort < ActiveRecord::Base
  belongs_to :course
  has_many :users, through: :enrollment
  belongs_to :location
  has_many :assignments
  #add subject/instructor columns to this table
end