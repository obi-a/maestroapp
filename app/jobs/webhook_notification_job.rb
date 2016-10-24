class WebhookNotificationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(params)
    ActiveRecord::Base.connection_pool.with_connection do
      monitor = RagiosMonitor.where(ragiosid: params[:ragiosid]).first
      mailing_list = monitor&.email_notifiers&.pluck(:email)
      if mailing_list
        if params[:event].to_sym == :failed
          NotificationsMailer.failed(mailing_list, params[:monitor], params[:test_result]).deliver_now
        elsif params[:event].to_sym == :resolved
          NotificationsMailer.resolved(mailing_list, params[:monitor], params[:test_result]).deliver_now
        end
      end
    end
  end
end
