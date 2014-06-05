module FormatHelper

   def pretty_date(date)
    date.strftime("%b %Y")
  end

  def pretty_due_date(date)
    date.strftime("%b %e")
  end

  def pretty_cohort_name(cohort)
    "#{cohort.location.name}: #{cohort.course.name} (#{pretty_date(cohort.start_date)})"
  end

  def current_cohort(user)
    #alter later for better query
    user.cohorts.first 
  end

  def grab_gravatar(user = current_user)
    #store in db?
    email = user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def pretty_workflow_state(string)
    string.gsub(/_/, ' ').capitalize
  end

end
