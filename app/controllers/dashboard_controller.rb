class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @ragios_monitors = RagiosMonitor.where(user_id: current_user)
  end
end
