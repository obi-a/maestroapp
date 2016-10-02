class MonitorCreationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(monitor_id, webhook_url)
    client = RagiosMonitor.client
    ActiveRecord::Base.connection_pool.with_connection do
      m = RagiosMonitor.find(monitor_id)
      unless m.status > 0
        options = {
          monitor: m.title,
          url: m.url,
          via: "webhook_notifier",
          webhook_url: webhook_url,
          user: m.user.email,
          plugin: m.monitor_type,
          every: "#{m.hours}h#{m.minutes}m"
        }
        options[:browser] = "phantomjs"
        options[:exists?] = m.code
        response = client.create(options)

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
end
