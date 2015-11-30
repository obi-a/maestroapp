require 'rails_helper'

RSpec.describe "ragios_monitors/index", type: :view do
  before(:each) do
    assign(:ragios_monitors, [
      RagiosMonitor.create!(
        :title => "Title",
        :description => "MyText",
        :url => "Url",
        :duration => "9.99",
        :contact => "Contact",
        :ragiosid => "Ragiosid",
        :string => "String",
        :code => "MyText",
        :type => "Type",
        :monitor_json => "MyText",
        :user => nil
      ),
      RagiosMonitor.create!(
        :title => "Title",
        :description => "MyText",
        :url => "Url",
        :duration => "9.99",
        :contact => "Contact",
        :ragiosid => "Ragiosid",
        :string => "String",
        :code => "MyText",
        :type => "Type",
        :monitor_json => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of ragios_monitors" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    assert_select "tr>td", :text => "Ragiosid".to_s, :count => 2
    assert_select "tr>td", :text => "String".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
