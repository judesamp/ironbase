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

  private

  def ensure_admin
    unless current_user.present? and current_user.has_role? :admin
      redirect_to root_path, notice: "This is not the page you are looking for."
    end
  end
  
end