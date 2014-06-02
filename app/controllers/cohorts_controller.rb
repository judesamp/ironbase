class CohortsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      redirect_to location_path(@cohort.location_id), notice: "Your cohort has been created!"
    else
      redirect_to ironyard_dashboard_users_path, notice: "We were unable to create your cohort. Please try again."
    end
  end

  def show
    @cohort = Cohort.find(params[:id])
    @active_cohort_users = @cohort.users.joins(:enrollments).where("enrollments.status" => "active").uniq
    puts @active_cohort_users.inspect
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      redirect_to :back, notice: "Your cohort has been updated."
    else
      redirect_to :back, notice: "We were unable to update your cohort. Please try again."
    end
  end

  private
  def cohort_params
    params.require(:cohort).permit(:name, :subject, :start_date, :end_date, :course_id, :location_id, :instructor)
  end

end