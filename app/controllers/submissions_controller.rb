class SubmissionsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    @submission = Submission.new(submission_params)
    @assignment = Assignment.find(@submission.assignment_id)
    
      if @submission.save
        @submission.submit!
        redirect_to assignment_path(@submission.assignment_id), notice: 'Your assignment submission has been created.'
      else
        redirect_to assignment_path(@submission.assignment_id), notice: "There was a problem creating your assignment submission. Please try again. Keep in mind that you can only create one submission per assignment. Please feel free to edit this submission at any time."
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
    @comments = @submission.comments
    @user = current_user
    @cohort = current_cohort(@user)
    @assignment = Assignment.find(@submission.assignment_id)
  end

  def resubmit
    @submission = Submission.find(params[:id])
    @assignment = Assignment.find(@submission.assignment_id)
    if @submission.update(submission_params)
      @submission.resubmit!
      redirect_to submission_path(@submission), notice: 'Your assignment submission has been successfully update.'
    else
      redirect_to submission_path(@submission), notice: "There was a problem updating your assignment submission. Please try again."
    end
  end

  # code not working but should be here; resides in comments for now.
  # def review
  #   @submission =  Submission.find(params[:id])
  #   if @submission.workflow_state == "awaiting_review"
  #     @submission.review!
  #   end
  #   redirect_to @submission
  # end

  # def accept
  #   @submission = Submission.find(params[:id])
  #   if @submission.workflow_state == 'being_reviewed'
  #     @submission.accept!
  #   end
  #   @comment = @submission.commentable.build(params[:comments])
  #   if @comment.save
  #     redirect_to :back
  #   else
  #     redirect_to :back
  #   end
  # end

  def reject
    @submission = @submission.find(params[:id])
    @submission.reject!
  end

  private
  def submission_params
    params.require(:submission).permit(:content, :notes, :assignment_id, :user_id, comments_attributes: [:id, :content, :first_name, :user_id])
  end
end