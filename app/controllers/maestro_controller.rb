require 'parser'

class MaestroController < ApplicationController
  before_filter :authenticate_user!

  def test
    response = {ok: true}
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
end
