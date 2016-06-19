class WebhookNotificationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(params)
    if params[:event].to_sym == :failed
      NotificationsMailer.failed(mailing_list, params[:monitor], params[:test_result])
    elsif params[:event].to_sym == :resolved
      NotificationsMailer.resolved(mailing_list, params[:monitor], params[:test_result])
    end
  end
end
