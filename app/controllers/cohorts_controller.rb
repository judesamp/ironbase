class CohortsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      gflash success: "Your cohort has been created!"
      redirect_to location_path(@cohort.location_id)
    else
      gflash error: "We were unable to create your cohort. Please try again."
      redirect_to ironyard_dashboard_users_path
    end
  end

  def show
    @cohort = Cohort.find(params[:id])
    @active_cohort_users = @cohort.users.joins(:enrollments).where("enrollments.status" => "active").uniq
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      gflash notice: "Your cohort has been updated."
      redirect_to :back
    else
      gflash error: "We were unable to update your cohort. Please try again."
      redirect_to :back
    end
  end

  def prepopulate_date
    @cohort = Cohort.find 6
    date = Date.parse(params[:start_date])
    new_date = date + 3.months
    @new_date = new_date
    respond_to do |format|
      format.js
    end
  end

  def edit_modal
    @cohort = Cohort.find(params[:cohort_id])
    @location = Location.find(params[:location_id])
    respond_to do |format|
      format.js
    end
  end

  def add_instructor_modal
    @cohort = Cohort.find(params[:cohort_id])
  end

  def remove_instructor_modal
    @cohort = Cohort.find(params[:cohort_id])
  end

  private
  def cohort_params
    params.require(:cohort).permit(:name, :subject, :start_date, :end_date, :course_id, :location_id, :instructor_id)
  end

end