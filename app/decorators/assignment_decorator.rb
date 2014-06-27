class AssignmentDecorator < Draper::Decorator
  delegate_all

  def add_identifier
    if h.current_user.first_name.present?
      "#{h.current_user.first_name}"
    else
      "#{h.current_user.email}"
    end
  end

  def display_current_status(submission)
    if @submission.nil? || @submission.workflow_state.nil?
      "Not Yet Submitted"
    else
      pretty_workflow_state(@submission.workflow_state)
    end
  end

  def assignment_nav(submission)
    if h.current_user.has_role? :admin
      h.render 'admin_assignment_nav'
    else
      h.render 'user_assignment_nav', submission: submission
    end
  end

  def side_box(assignment, submission)
    if h.current_user.has_role? :admin
      h.render 'updated_side_box', assignment: assignment
    else
      h.render 'initial_side_box', submission: submission, assignment: assignment
    end
  end

  def admin_or_user_modals(assignment)
    if h.current_user.has_role? :admin
      h.render "edit_assignment_modal", assignment: assignment
    else
      h.render "submit_submission_modal", assignment: assignment
    end
  end

  def edit_submission_modal(submission)
    unless submission.nil?
      h.render "edit_submission_modal"
    end
  end
  
end