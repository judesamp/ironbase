class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  helper_method :enrollment_status_active?, :pretty_date, :pretty_cohort_name, :pretty_due_date, :current_cohort, :grab_gravatar, :pretty_workflow_state, :user_submission
  include FormatHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: "Access denied"
  end

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

  def user_submission(user, assignment)
    Submission.where("user_id = ? AND assignment_id = ?", user.id, assignment.id).first
  end

  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :admin, :email, :password, :password_confirmation)}
  end

end
