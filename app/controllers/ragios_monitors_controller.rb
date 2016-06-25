class RagiosMonitorsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_ragios_monitor, only: [:edit, :update, :show, :find, :destroy]
  before_action :set_client, only: [:events, :find, :test, :stop, :start, :update, :destroy]

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
    add_breadcrumb "All Monitors", dashboard_index_path
    add_breadcrumb "Add New Monitor", new_ragios_monitor_path
  end

  # GET /ragios_monitors/1/edit
  def edit
  end

  def find
    response = @client.find(params[:ragios_id])
    response[:hours], response[:minutes] = @ragios_monitor.hours, @ragios_monitor.minutes
    render json: response.to_json
  end

  # POST /ragios_monitors
  def create
    @ragios_monitor = RagiosMonitor.new(
      url: params[:url],
      title: params[:title],
      hours: params[:hours].to_i,
      minutes: params[:minutes].to_i
    )
    @ragios_monitor.monitor_type =
    if params[:monitor_type].to_sym == :http_check
      "url_monitor"
    elsif params[:monitor_type].to_sym == :real_browser_monitor
      "uptime_monitor"
    end
    @ragios_monitor.user = current_user
    @ragios_monitor.code = params[:source_code] if params[:monitor_type].to_sym == :real_browser_monitor


    if @ragios_monitor.save
      MonitorCreationJob.perform_later(@ragios_monitor.id, webhook_notifications_url)
      redirect_to dashboard_index_path, info: 'Ragios monitor was successfully created.'
    else
      render :new
    end
  end

  def stop
    response = @client.stop(params[:ragios_id])
    render json: response.to_json
  end

  def test
    response = @client.test(params[:ragios_id])
    render json: response.to_json
  end

  def start
    response = @client.start(params[:ragios_id])
    render json: response.to_json
  end

  def events
    response = @client.events(params[:ragios_id], "1980","2040", 50)
    render json: response.to_json
  end

  # PATCH/PUT /ragios_monitors/1
  def update
    response = @client.update(
      @ragios_monitor.ragiosid,
      url: params[:url],
      every: "#{params[:hours]}h#{params[:minutes]}m",
      monitor: params[:title]
    )
    @ragios_monitor.update(ragios_monitor_params)
    render json: response.to_json
  end

  # DELETE /ragios_monitors/1
  def destroy
    response = @client.delete(@ragios_monitor.ragiosid)
    @ragios_monitor.destroy
    render json: response.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ragios_monitor
      @ragios_monitor = RagiosMonitor.find(params[:id])
    end

    def set_client
      @client ||= Ragios::Client.new
    end

    # Only allow a trusted parameter "white list" through.
    def ragios_monitor_params
      params.require(:ragios_monitor).permit(:title, :description, :url, :hours, :minutes, :ragiosid, :string, :code, :type, :monitor_json, :user_id)
    end
end
