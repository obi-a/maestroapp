class User < ActiveRecord::Base
  has_many :ragios_monitors
  has_many :email_notifiers
  before_create :set_role
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  def set_role
    self.add_role :regular
  end

  def after_confirmation
    notifier = self.email_notifiers.build(email: self.email, verified: true)
    notifier.save!
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later(queue: :default)
  end

  def cached_active_monitors
    Rails.cache.fetch([self.class.name, id, :active_monitors], expires_in: 240.hours) do
      client = RagiosMonitor.client
      client.where(contact: self.email)
    end
  end

  def cached_monitors
    Rails.cache.fetch([self.class.name, id, :monitors], expires_in: 240.hours) do
      RagiosMonitor.where(user_id: self).to_a
    end
  end

  def cached_monitor(this_monitor_id)
    Rails.cache.fetch([self.class.name, id, this_monitor_id, :monitor], expires_in: 240.hours) do
      RagiosMonitor.where(user_id: self, id: this_monitor_id).first
    end
  end

  def cached_ragios_monitor(ragiosid)
    Rails.cache.fetch([self.class.name, id, ragiosid, :ragios_monitor], expires_in: 240.hours) do
      RagiosMonitor.where(ragiosid: ragiosid, user_id: self.id).first
    end
  end

  def cached_email_notifiers
    Rails.cache.fetch([self.class.name, id, :email_notifiers], expires_in: 240.hours) do
      self.email_notifiers.to_a
    end
  end

  def cached_verified_email_notifiers
    Rails.cache.fetch([self.class.name, id, :verified_email_notifiers], expires_in: 240.hours) do
      self.email_notifiers.where(verified: true).to_a
    end
  end

  def cached_find_monitor(ragiosid)
    Rails.cache.fetch([self.class.name, id, ragiosid, :find_monitor], expires_in: cached_event_expires_in(ragiosid)) do
      monitor = self.ragios_monitors.where(ragiosid: ragiosid).first
      client = RagiosMonitor.client
      response = monitor ? client.find(ragiosid) : {}
      response[:hours], response[:minutes] = monitor.hours, monitor.minutes
      response
    end
  end

  def cached_event_expires_in(ragiosid)
    Rails.cache.fetch([self.class.name, id, ragiosid, :event_expires_in], expires_in: 240.hours) do
      monitor = self.ragios_monitors.where(ragiosid: ragiosid).first
      if monitor
        ((monitor.hours * 60 * 60) + (monitor.minutes * 60)) - 5
      end.to_i
    end
  end

  def cached_monitor_events(ragiosid)
    Rails.cache.fetch([self.class.name, id, ragiosid, :monitor_events], expires_in: cached_event_expires_in(ragiosid)) do
      client = RagiosMonitor.client
      client.events(ragiosid, "1980","2040", 50)
    end
  end
end
