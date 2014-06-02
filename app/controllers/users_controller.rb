require 'digest/md5'

class UsersController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  before_filter :ensure_admin, only: [:course_dashboard, :cohort_dashboard]

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
    puts user.inspect
    puts @cohort.inspect
    enrollment_relation = Enrollment.where("cohort_id = ? AND user_id = ?", @cohort.id, user.id)
    puts enrollment_relation.inspect
    enrollment = enrollment_relation.first
    if @cohort.users.include? user
      if enrollment.status == "active"
        respond_to do |format|
          format.js {render plain: '0'}
        end
      else
        enrollment.status = "active"
        enrollment.save
        @active_cohort_users = @cohort.users.joins(:enrollments).where("enrollments.status" => "active")
        puts @active_cohort_users.inspect
        respond_to do |format|
          format.js
        end
      end
    else

      @cohort.users << user unless @cohort.users.include?(user)
      @active_cohort_users = @cohort.users.joins(:enrollments).where("enrollments.status" => "active")

      respond_to do |format|
        format.js
      end
    end
  end

  def remove_user_from_cohort
    @cohort = Cohort.find(params[:users][:cohort_id])
    enrollment_relation = Enrollment.where("cohort_id = ? AND user_id = ?", params[:users][:cohort_id], params[:users][:user_id])
    enrollment =  enrollment_relation.first
    puts 'above inspect'
    puts enrollment.inspect
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

  private

  def enrollment_exists?
    !Enrollment.find_by_cohort_id(params[:users][:cohort_id]).nil?
  end

  def ensure_admin
    unless current_user.present? and current_user.has_role? :admin
      redirect_to root_path, notice: "This is not the page you are looking for."
    end
  end
  
end