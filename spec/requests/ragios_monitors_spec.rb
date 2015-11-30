require 'rails_helper'

RSpec.describe "RagiosMonitors", type: :request do
  describe "GET /ragios_monitors" do
    it "works! (now write some real specs)" do
      get ragios_monitors_path
      expect(response).to have_http_status(200)
    end
  end
end
