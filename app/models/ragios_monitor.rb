class RagiosMonitor < ActiveRecord::Base
  belongs_to :user

  STATUSES = %w(pending active cannot_create)

  def self.status(value)
    STATUSES.index(value.to_s)
  end
end
