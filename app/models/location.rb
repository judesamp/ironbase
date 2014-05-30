class Location < ActiveRecord::Base
  has_many :courses
  has_many :cohorts
end