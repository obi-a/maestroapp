class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @active_monitors = current_user.cached_active_monitors
    @monitors = current_user.cached_monitors
    add_breadcrumb "All Monitors", dashboard_index_path
  end

  def notifications
    @email_notifiers = current_user.cached_email_notifiers
    add_breadcrumb "All Monitors", dashboard_index_path
    add_breadcrumb "Notifications", notifications_dashboard_index_path
  end

  def monitor
    @monitor = current_user.cached_monitor(params[:id])
    @email_notifiers = current_user.cached_verified_email_notifiers
    @current_alert_emails = @monitor.cached_email_notifiers.map(&:email)
    add_breadcrumb "All Monitors", dashboard_index_path
    add_breadcrumb @monitor.title.to_s, monitor_dashboard_path
  end
end
