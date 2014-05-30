class CoursesController < ApplicationController

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to ironyard_dashboard_users_path, notice: "The course was created successfully!"
    else
      redirect_to ironyard_dashboard_users_path, notice: "Something went wrong. Please try again."
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