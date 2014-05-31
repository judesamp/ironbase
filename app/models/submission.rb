class Submission < ActiveRecord::Base
  include Workflow

  belongs_to :user
  belongs_to :assignment
  has_many :comments, as: :commentable
  has_many :links, as: :linkable

  workflow do
    state :new do
      event :submit, :transitions_to => :awaiting_review
    end
    state :awaiting_review do
      event :review, :transitions_to => :being_reviewed
    end
    state :being_reviewed do
      event :accept, :transitions_to => :complete
      event :reject, :transitions_to => :incomplete
    end
    state :incomplete do
      event :resubmit, :transitions_to => :awaiting_review
    end
    state :complete
  end

end