class RagiosMonitorsController < ApplicationController
  before_action :set_ragios_monitor, only: [:show, :edit, :update, :destroy]

  # GET /ragios_monitors
  def index
    @ragios_monitors = RagiosMonitor.where(user_id: current_user)
  end

  # GET /ragios_monitors/1
  def show
  end

  # GET /ragios_monitors/new
  def new
    @ragios_monitor = RagiosMonitor.new
  end

  # GET /ragios_monitors/1/edit
  def edit
  end

  # POST /ragios_monitors
  def create
    if params[:monitor_type].to_sym == :http_check
      @ragios_monitor = RagiosMonitor.new(
        url: params[:url],
        title: params[:title],
        hours: params[:hours].to_i,
        minutes: params[:minutes].to_i,
        monitor_type: "url_monitor"
      )
      @ragios_monitor.user = current_user
    end

    if @ragios_monitor.save
      UrlMonitorCreationJob.perform_later(@ragios_monitor.id)
      redirect_to dashboard_index_path, notice: 'Ragios monitor was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ragios_monitors/1
  def update
    if @ragios_monitor.update(ragios_monitor_params)
      redirect_to @ragios_monitor, notice: 'Ragios monitor was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ragios_monitors/1
  def destroy
    @ragios_monitor.destroy
    redirect_to ragios_monitors_url, notice: 'Ragios monitor was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ragios_monitor
      @ragios_monitor = RagiosMonitor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ragios_monitor_params
      params.require(:ragios_monitor).permit(:title, :description, :url, :duration, :contact, :ragiosid, :string, :code, :type, :monitor_json, :user_id)
    end
end
