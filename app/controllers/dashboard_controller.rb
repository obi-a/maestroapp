class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @client = RagiosMonitor.client
    @active_monitors = @client.where(user: current_user.email)
    @monitors = RagiosMonitor.where(user_id: current_user)
    add_breadcrumb "All Monitors", dashboard_index_path
  end

  def notifications
    @email_notifiers = current_user.email_notifiers
    add_breadcrumb "All Monitors", dashboard_index_path
    add_breadcrumb "Notifications", notifications_dashboard_index_path
  end

  def monitor
    @monitor = RagiosMonitor.where(user_id: current_user, id: params[:id]).first
    @email_notifiers = current_user.email_notifiers#.pluck(:email)
    @current_alert_emails = @monitor.email_notifiers.pluck(:email)
    add_breadcrumb "All Monitors", dashboard_index_path
    add_breadcrumb @monitor.title.to_s, monitor_dashboard_path
  end
end
