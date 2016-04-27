class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @monitors = RagiosMonitor.where(user_id: current_user)
  end

  def monitor
    @monitor = RagiosMonitor.where(user_id: current_user, id: params[:id])
  end
end
