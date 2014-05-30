class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :ensure_admin, only: [:course_dashboard, :cohort_dashboard]

  def dashboard

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
    if @cohort.users.include? user
      respond_to do |format|
        format.js { render status: 500}
      end
    else
      @cohort.users << user
      respond_to do |format|
        format.js
      end
    end
    
  end

  private

  def ensure_admin
    unless current_user.present? and current_user.has_role? :admin
      redirect_to root_path, notice: "This is not the page you are looking for."
    end
  end
  
end