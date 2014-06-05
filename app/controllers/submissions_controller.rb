class SubmissionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @submission = Submission.new(submission_params)
    @assignment = Assignment.find(@submission.assignment_id)
    
      if @submission.save
        @submission.submit!
        success: 'Your assignment submission has been created.'
        redirect_to assignment_path(@submission.assignment_id)
      else
        error: "There was a problem creating your assignment submission. Please try again. Keep in mind that you can only create one submission per assignment. Please feel free to edit this submission at any time."
        redirect_to assignment_path(@submission.assignment_id)
      end
  end

  def update
    @submission = Submission.find(params[:id])
    @assignment = Assignment.find(@submission.assignment_id)
    if @submission.update(submission_params)
      gflash success: 'Your assignment submission has been successfully update.'
      redirect_to assignment_path(@submission.assignment_id)
    else
      gflash error: "There was a problem updating your assignment submission. Please try again."
      redirect_to assignment_path(@submission.assignment_id)
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
      gflash success: 'Your assignment submission has been successfully updated and resubmitted.'
      redirect_to submission_path(@submission)
    else
      gflash error: 'There was a problem. Please try again.'
      redirect_to submission_path(@submission)
    end
  end

  def review
    @submission =  Submission.find(params[:id])
    if @submission.workflow_state == "awaiting_review"
      @submission.review!
    end
    redirect_to @submission
  end

  # code not working but should be here; resides in comments for now.
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

  # def reject
  #   @submission = @submission.find(params[:id])
  #   @submission.reject!
  # end

  private
  def submission_params
    params.require(:submission).permit(:content, :notes, :assignment_id, :user_id, comments_attributes: [:id, :content, :first_name, :user_id])
  end
end