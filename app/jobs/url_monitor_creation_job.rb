class UrlMonitorCreationJob < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(monitor_id)
    ActiveRecord::Base.connection_pool.with_connection do
      monitor = RagiosMonitor.find(monitor_id)
    end
  end
end