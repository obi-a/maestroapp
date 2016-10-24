class AlertEmailVerificationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(email_notifier_id, verification_url, firstname)
    ActiveRecord::Base.connection_pool.with_connection do
      notifier = EmailNotifier.find_by_id(email_notifier_id)
      return false unless notifier
      notifier.update_attribute(:token_timestamp, DateTime.now)
      AlertEmailVerificationMailer.verify(notifier.email, verification_url, firstname).deliver_now
    end
  end
end
