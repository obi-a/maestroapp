class RagiosMonitor < ActiveRecord::Base
  belongs_to :user
  has_many :email_notifiers

  after_commit :flush_cache

  STATUSES = %w(pending active cannot_create)

  TYPE = {
    http_check: "url_monitor",
    real_browser_monitor: "uptime_monitor"
  }.freeze

  def self.status(value)
    STATUSES.index(value.to_s)
  end

  def self.client
    @ragios_client ||= Ragios::Client.new(
      username: ENV["RAGIOS_SERVER_USERNAME"],
      password: ENV["RAGIOS_SERVER_PASSWORD"],
      address: ENV["RAGIOS_SERVER_URL"],
      port: ENV["RAGIOS_SERVER_PORT"]
    )
  end

  def self.cached_expire_in(ragiosid)
    Rails.cache.fetch("monitor_#{ragiosid}_expire_in") do
      monitor = RagiosMonitor.where(ragiosid: ragiosid).first
      if monitor
        ((monitor.hours * 60 * 60) + (monitor.minutes * 60)) - 5
      end
    end
  end

  def cached_email_notifiers
    Rails.cache.fetch([self.class.name, id, :email_notifiers], expires_in: 240.hours) do
      self.email_notifiers.to_a
    end
  end


  def flush_cache
    Rails.cache.delete([self.user.class.name, self.user_id, :active_monitors])
    Rails.cache.delete([self.user.class.name, self.user_id, :monitors])
    Rails.cache.delete([self.user.class.name, self.user_id, self.id, :monitor])
    Rails.cache.delete([self.user.class.name, self.user_id, self.ragiosid, :find_monitor])
    Rails.cache.delete([self.user.class.name, self.user_id, self.ragiosid, :event_expires_in])
    Rails.cache.delete([self.user.class.name, self.user_id, self.ragiosid, :monitor_events])
    Rails.cache.delete([self.user.class.name, self.user_id, self.ragiosid, :ragios_monitor])
  end
end
