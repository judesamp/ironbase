class AssignmentsController < ApplicationController

  def create
    @assignment = Assignment.new(assignment_params)
    if @assignment.save
      redirect_to cohort_path(@assignment.cohort_id)
    else
      redirect_to cohort_path(@assignment.cohort_id)

    end
  end

  def show
    @assignment = Assignment.find(params[:id])
    submissions = @assignment.submissions.where(:user_id => current_user.id)
    @submission = submissions.first
    puts "WE are HERE!!!!!!!!!!"
    puts @submission.inspect
  end

  private
  def assignment_params
    params.require(:assignment).permit(:name, :description, :due_date, :cohort_id)
  end

end

