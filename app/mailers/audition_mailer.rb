class AuditionMailer < ApplicationMailer
  def assign_audition(audition)
    @audition = audition
    mail(to: "#{@audition.assigned_to}", subject: "Audition Assigned")
  end
  def audition_status_email(audition)
    @audition = audition
    mail(to: "#{@audition.email}", subject: "Audition Status")
  end
end
