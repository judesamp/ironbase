class AssignmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      gflash success: "Your assignment has been created!"
      redirect_to cohort_path(@assignment.cohort_id)
    else
      gflash error: "We were unable to create your assignment. Please try again."
      redirect_to cohort_path(@assignment.cohort_id)
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update(assignment_params)
      gflash success: "Your assignment has been updated!"
      redirect_to :back
    else
      gflash error: "We were unable to update your assignment. Please try again."
      redirect_to :back
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
    @comments = @assignment.comments
    submissions = @assignment.submissions.where(:user_id => current_user.id)
    @submission = submissions.first
  end

  def submissions
    @assignment = Assignment.find(params[:id])
    @submissions = @assignment.submissions
  end

  private
  def assignment_params
    params.require(:assignment).permit(:name, :description, :due_date, :cohort_id)
  end

end

