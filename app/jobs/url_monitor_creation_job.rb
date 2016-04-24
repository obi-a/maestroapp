class UrlMonitorCreationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(monitor_id)
    ragios = Ragios::Client.new
    ActiveRecord::Base.connection_pool.with_connection do
      m = RagiosMonitor.find(monitor_id)
      response = ragios.create(
        monitor: m.title,
        url: m.url,
        via: "gmail_notifier",
        contact: m.user.email,
        tag: m.user.id,
        plugin: "url_monitor",
        every: "#{m.hours}h#{m.minutes}m"
      )

      if response["error"]
        m.update_attributes(
          comment: response["error"],
          status: RagiosMonitor.status(:cannot_create)
        )
      else
        m.update_attributes(
          comment: "Successfully created",
          status: RagiosMonitor.status(:active),
          ragiosid: response[:_id],
          monitor_json: response.to_json
        )
      end
    end
  end
end
