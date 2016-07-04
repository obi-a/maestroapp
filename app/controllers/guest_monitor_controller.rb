class GuestMonitorController < ApplicationController
  def create
    @guest_monitor = RagiosMonitor.new(url: params[:url])
    @guest_monitor.monitor_type = "guest_monitor"
    @guest_monitor.user = guest_user
    @guest_monitor.code = params[:source_code]

    @guest_monitor.save
    redirect_to new_ragios_monitor_path,  info: "Complete your monitor"
  end
end
