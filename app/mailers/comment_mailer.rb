class CommentMailer < ActionMailer::Base
  default from: "from@example.com"

  def submission_comment_email(commenter, receiver, submission, comment)
    @commenter = commenter
    @receiver = receiver
    @comment = comment
    @submission = submission

    mail(to: @receiver.email, subject: "#{@commenter.name} commented on your #{@submission.assignment.name} submission")
  end

  def assignment_comment_email(commenter, cohort, assignment, comment)
    @commenter = commenter
    @cohort = cohort
    @comment = comment
    @assignment = assignment
    @cohort.users.each do |user|
      unless user == @commenter
        mail(to: user.email, subject: "#{commenter} just commented on #{assignment.name}")
      end
    end
  end
end
