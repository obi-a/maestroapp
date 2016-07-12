class RagiosMonitor < ActiveRecord::Base
  belongs_to :user
  has_many :email_notifiers

  STATUSES = %w(pending active cannot_create)

  def self.status(value)
    STATUSES.index(value.to_s)
  end

  def self.client
    @ragios_client ||= Ragios::Client.new
  end
end
