class AuditionMailer < ApplicationMailer
  def assign_audition(audition)
    @audition = audition
    mail(to: "#{@audition.assigned_to}", subject: "Audition Assigned")
  end
end
