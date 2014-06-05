class CommentsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      send_comment_email(@comment)
      gflash success: "Your comment has been created!"
      redirect_to :back
    else
      gflash error: "There was a problem. We were unable to create your comment!"
      redirect_to :back
    end
  end

  def reject
    @submission = Submission.find(comment_params[:commentable_id])
    @submission.reject!
    @comment = Comment.new(comment_params)
    if @comment.save
      send_comment_email(@comment)
      gflash error: "The submission has been rejected!"
      redirect_to :back
    else
      gflash error: "There was a problem. We were unable to mark the submission as rejected. Please try again!"
      redirect_to :back
    end
  end

  def accept
    @submission = Submission.find(comment_params[:commentable_id])
    @submission.accept!
    @comment = Comment.new(comment_params)
    if @comment.save
      send_comment_email(@comment)
      gflash success: "The submission has been accepted!"
      redirect_to :back
    else
      gflash error: "There was a problem. We were unable to mark the submission as accepted. Please try again!"
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end

  def send_comment_email(comment)
    if comment.commentable_type == "Assignment"
      assignment = Assignment.find(comment.commentable_id)
      commenter, cohort = gather_data(comment, assignment)
      CommentMailer.assignment_comment_email(commenter, cohort, assignment, comment).deliver
    else
      submission = Submission.find(comment.commentable_id)
      assignment = Assignment.find(submission.assignment.id)
      commenter, cohort = gather_data(comment, assignment)
      if commenter.has_role? :admin
        receiver = User.find(submission.user_id)
        CommentMailer.submission_comment_email(commenter, receiver, submission, comment).deliver
      else
        receiver = User.find_by_id(cohort.instructor_id) #send to all admins connected to cohort?
        if receiver
          CommentMailer.submission_comment_email(commenter, receiver, submission, comment).deliver
        else
          gflash error: "Email not sent: no instructor set."
          return
        end
      end

    end
  end

  private

  def gather_data(comment, assignment)
    commenter = User.find(comment.user_id)   
    cohort = Cohort.find(assignment.cohort_id)
    return commenter, cohort
  end
end