module DashboardHelper
  def monitor_status(status)
    if status == RagiosMonitor.status(:cannot_create)
      "Could not create Monitor"
    elsif status == RagiosMonitor.status(:active)
      "active"
    elsif status == RagiosMonitor.status(:pending)
      "pending"
    end
  end
end
