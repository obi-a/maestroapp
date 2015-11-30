require "rails_helper"

RSpec.describe RagiosMonitorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ragios_monitors").to route_to("ragios_monitors#index")
    end

    it "routes to #new" do
      expect(:get => "/ragios_monitors/new").to route_to("ragios_monitors#new")
    end

    it "routes to #show" do
      expect(:get => "/ragios_monitors/1").to route_to("ragios_monitors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ragios_monitors/1/edit").to route_to("ragios_monitors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ragios_monitors").to route_to("ragios_monitors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ragios_monitors/1").to route_to("ragios_monitors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ragios_monitors/1").to route_to("ragios_monitors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ragios_monitors/1").to route_to("ragios_monitors#destroy", :id => "1")
    end

  end
end
