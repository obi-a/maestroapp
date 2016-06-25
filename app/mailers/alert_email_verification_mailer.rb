class AlertEmailVerificationMailer < ApplicationMailer

  def verify(email, verification_url, firstname)
    subject = "Please verify your email address"
    @firstname = firstname
    @verification_url = verification_url
    mail to: email, subject: subject
  end
end