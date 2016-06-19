class WebhookController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def notifications
    WebhookNotificationJob.perform_later(params)
    render json: {ok: true}.to_json
  end
end
