class CommentsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      send_comment_email(@comment)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def reject
    @submission = Submission.find(comment_params[:commentable_id])
    @submission.reject!
    @comment = Comment.new(comment_params)
    if @comment.save
      send_comment_email(@comment)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def accept
    @submission = Submission.find(comment_params[:commentable_id])
    @submission.accept!
    @comment = Comment.new(comment_params)
    if @comment.save
      send_comment_email(@comment)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end

  def send_comment_email(comment)
    if comment.commentable_type == "Assignment"
      commenter = User.find(comment.user_id)
      assignment = Assignment.find(comment.commentable_id)
      cohort = Cohort.find(assignment.cohort_id)
      CommentMailer.assignment_comment_email(commenter, cohort, assignment, comment).deliver
    else
      commenter = User.find(comment.user_id)
      submission = Submission.find(comment.commentable_id)
      assignment = Assignment.find(submission.assignment.id)
      cohort = Cohort.find(assignment.cohort_id)
      if commenter.has_role? :admin
        receiver = User.find(submission.user_id)
        CommentMailer.submission_comment_email(commenter, receiver, submission, comment).deliver
      else
        puts 'HHHHHHHHHHHH'
        puts cohort.inspect
        receiver = User.find_by_id(cohort.instructor_id) #send to all admins connected to cohort?
        if receiver
          CommentMailer.submission_comment_email(commenter, receiver, submission, comment).deliver
        else
          puts "Email not sent: no instructor set."
          return
        end
      end

    end
  end
end