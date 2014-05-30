class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :cohort

  validates_uniqueness_of :cohort_id, :scope => :user_id
end