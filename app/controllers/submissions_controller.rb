class SubmissionsController < ApplicationController

  def create
    @submission = Submission.new(submission_params)
    @assignment = Assignment.find(@submission.assignment_id)
    if @submission.save
      @submission.submit!
      redirect_to assignment_path(@submission.assignment_id), notice: 'Your assignment submission has been created.'
    else
      redirect_to assignment_path(@submission.assignment_id), notice: "There was a problem creating your assignment submission. Please try again."
    end
  end

  def update
    @submission = Submission.find(params[:id])
    @assignment = Assignment.find(@submission.assignment_id)
    if @submission.update(submission_params)
      redirect_to assignment_path(@submission.assignment_id), notice: 'Your assignment submission has been successfully update.'
    else
      redirect_to assignment_path(@submission.assignment_id), notice: "There was a problem updating your assignment submission. Please try again."
    end
  end

  def show
    @submission =  Submission.find(params[:id])
  end

  private
  def submission_params
    params.require(:submission).permit(:content, :notes, :assignment_id, :user_id)
  end
end