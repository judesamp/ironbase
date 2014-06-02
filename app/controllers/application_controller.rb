class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: "Access denied"
  end
  protect_from_forgery with: :exception
  helper_method :enrollment_status_active?, :pretty_date, :pretty_cohort_name, :pretty_due_date, :current_cohort, :grab_gravatar, :pretty_workflow_state, :user_submission
  
  def after_sign_in_path_for(resource)
    if resource.has_role? :admin
      ironyard_dashboard_users_path(resource)
    else
      dashboard_users_path(resource)
    end
  end

  def enrollment_status_active?(cohort, user)
    enrollment_relation = Enrollment.where("cohort_id = ? AND user_id = ?", cohort.id, user.id)
    enrollment = enrollment_relation.first
    if enrollment.present?
      enrollment.status == "active"
    else
      false
    end
  end

  def pretty_date(date)
    date.strftime("%b %Y")
  end

  def pretty_due_date(date)
    date.strftime("%b %e")
  end

  def pretty_cohort_name(cohort)
    "#{cohort.location.name}: #{cohort.course.name} (#{pretty_date(cohort.start_date)})"
  end

  def current_cohort(user)
    #alter later for better query
    user.cohorts.first 
  end

  def grab_gravatar(user = current_user)
    #store in db?
    email = user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def pretty_workflow_state(string)
    string.gsub(/_/, ' ').capitalize
  end

  def user_submission(user, assignment)
    Submission.where("user_id = ? AND assignment_id = ?", user.id, assignment.id).first
  end

end
