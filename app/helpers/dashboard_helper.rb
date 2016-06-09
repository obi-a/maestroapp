module DashboardHelper
  def monitor_status(status, ragiosid, active_monitors)
    if status == RagiosMonitor.status(:cannot_create)
      '<span class="label alert">Could not create Monitor</span>'
    elsif status == RagiosMonitor.status(:active)
      m = active_monitors.detect { |i| i[:_id] == ragiosid }
      if m
        if m[:status_] == "active"
          ("<span class=\"label info\">active</span>").html_safe
        elsif m[:status_] == "stopped"
          ("<span class=\"label warning\">stopped</span>").html_safe
        else
          ("<span class=\"label secondary\">#{m[:status_]}</span>").html_safe
        end
      else
        ('<span class="label alert">unknown</span>').html_safe
      end
    elsif status == RagiosMonitor.status(:pending)
      ('<span class="label warning">pending</span>').html_safe
    end
  end
end


