class CoursesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    @course = Course.new(course_params)
    if @course.save
      gflash success: "The course was created successfully!"
      redirect_to ironyard_dashboard_users_path 
    else
      gflash error: "Something went wrong. Please try again."
      redirect_to ironyard_dashboard_users_path 
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  private
  def course_params
    params.require(:course).permit(:name, :syllabus)
  end

end