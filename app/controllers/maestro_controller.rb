require 'parser'

class MaestroController < ApplicationController
 # before_filter :authenticate_user!
  before_action :set_client, only: [:test]

  def test
    response = begin
      @client.maestro_test(params[:url], params[:source_code])
    rescue Ragios::ClientException => e
      err = JSON.parse e.message
      {results: [["error", err["error"] ]]}
    end
    render json: response.to_json
  end

  def validate
    response = begin
      MaestroLangParser.new.parse(params[:source_code])
      {ok: true}
    rescue ParserSyntaxError => e
      {error: e.message}
    end
    render json: response.to_json
  end

  private

    def set_client
      @client ||= RagiosMonitor.client
    end
end
