class WebhookController < ApplicationController
  skip_before_filter :verify_authenticity_token

=begin
  {:event=>"resolved",
   :ragiosid=>"870217b5-37ee-4769-951a-13a776bd1f1e",
   :monitor=>{
    :_id=>"870217b5-37ee-4769-951a-13a776bd1f1e",
    :_rev=>"7-b0b3bcf2571c9218e245e3b10811485a",
    :monitor=>"this ninja shit",
    :url=>"http://obi-akubue.org",
    :via=>["webhook_notifier"],
    :webhook_url=>"http://localhost:3000/webhook/notifications",
    :user=>"obi.akubue@gmail.com",
    :plugin=>"url_monitor",
    :every=>"0h5m",
    :browser=>"firefox headless",
    :exists?=>nil,
    :created_at_=>"2016-06-18T06:09:12Z",
    :status_=>"active",
    :type=>"monitor"},
    :test_result=>{"HTTP GET Request to http://obi-akubue.org"=>200}
  }

  {
    :event=>"failed",
    :ragiosid=>"870217b5-37ee-4769-951a-13a776bd1f1e",
    :monitor=>{
      :_id=>"870217b5-37ee-4769-951a-13a776bd1f1e",
      :_rev=>"8-5c2dc9f1846df5b6d1e651c4845c9d5c",
      :monitor=>"this ninja shit",
      :url=>"http://obi-akubuekkk.org",
      :via=>["webhook_notifier"],
      :webhook_url=>"http://localhost:3000/webhook/notifications",
      :user=>"obi.akubue@gmail.com",
      :plugin=>"url_monitor",
      :every=>"0h5m",
      :browser=>"firefox headless",
      :exists?=>nil,
      :created_at_=>"2016-06-18T06:09:12Z",
      :status_=>"active",
      :type=>"monitor"
    },
    :test_result=>{"HTTP GET Request to http://obi-akubuekkk.org"=>"getaddrinfo: Name or service not known (SocketError)"}
  }
=end

  def notifications

  end
end
