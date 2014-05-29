class Assignment < ActiveRecord::Base
  has_many :users, through: :assignment_queue
  has_many :submissions
  belongs_to :cohort
  #has_many :comments, as: :commentable
  has_many :links, as: :linkable

  #add due_date to assignment
end