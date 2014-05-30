class CohortsController < ApplicationController

  def create
    @cohort = Cohort.new(cohort_params)
    puts @cohort
    if @cohort.save
      redirect_to location_path(@cohort.location_id), notice: "Your cohort has been created!"
    else
      redirect_to ironyard_dashboard_users_path, notice: "We were unable to create your cohort. Please try again."
    end
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  private
  def cohort_params
    params.require(:cohort).permit(:name, :subject, :start_date, :end_date, :course_id, :location_id, :instructor)
  end

end