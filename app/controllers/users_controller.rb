require 'digest/md5'

class UsersController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  #before_filter :ensure_admin, only: [:course_dashboard, :cohort_dashboard]

  def dashboard
    #query this in a different way later
    @user = current_user
    @cohort = current_user.cohorts.first
  end

  def ironyard_dashboard
    @locations = Location.all
    @courses = Course.all
  end

  def cohort_dashboard
  end

  def add_user_to_cohort
    user = User.find(params[:users][:user_id])
    @cohort = Cohort.find(params[:users][:cohort_id])
    @cohort.users << user unless @cohort.users.include?(user)
    enrollment = find_enrollment(params[:users][:cohort_id], params[:users][:user_id]) 
    enrollment.status = "active"
    if enrollment.save!
      @active_cohort_users = @cohort.users.joins(:enrollments).where("enrollments.status" => "active")

      respond_to do |format|
        format.js
      end
    end
  end

  def remove_user_from_cohort
    @cohort = Cohort.find(params[:users][:cohort_id])
    enrollment = find_enrollment(params[:users][:cohort_id], params[:users][:user_id]) 
    enrollment.status = "inactive"
    if enrollment.save!
      @active_cohort_users = @cohort.users.joins(:enrollments).where("enrollments.status" => "active")
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js {render status: 500}
      end
    end
  end

  def make_admin
    user = User.find(params[:users][:user_id])
    user.add_role :admin
  end

  private

  def enrollment_exists?
    !Enrollment.find_by_cohort_id(params[:users][:cohort_id]).nil?
  end

  def ensure_admin
    unless current_user.present? and current_user.has_role? :admin
      gflash notice: "This is not the page you are looking for."
      redirect_to root_path
    end
  end

  def find_enrollment(cohort_id, user_id)
    Enrollment.find_by("cohort_id = ? AND user_id = ?", cohort_id, user_id)
  end
  
end