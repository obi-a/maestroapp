class RagiosMonitor < ActiveRecord::Base
  belongs_to :user

  STATUSES = %w(pending active)

  def self.status(value)
    STATUSES.index(value.to_s)
  end
end
