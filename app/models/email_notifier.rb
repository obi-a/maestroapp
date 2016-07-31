class EmailNotifier < ActiveRecord::Base
  belongs_to :user
  belongs_to :ragios_monitor
  has_secure_token :verification_token
  validates_format_of :email, with: Devise::email_regexp

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete([self.user.class.name, self.user_id, :email_notifiers])
    Rails.cache.delete([self.user.class.name, self.user_id, :verified_email_notifiers])
    Rails.cache.delete([self.ragios_monitor.class.name, self.ragios_monitor_id, :email_notifiers])
  end
end
