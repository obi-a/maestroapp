require 'rails_helper'

RSpec.describe "ragios_monitors/edit", type: :view do
  before(:each) do
    @ragios_monitor = assign(:ragios_monitor, RagiosMonitor.create!(
      :title => "MyString",
      :description => "MyText",
      :url => "MyString",
      :duration => "9.99",
      :contact => "MyString",
      :ragiosid => "MyString",
      :string => "MyString",
      :code => "MyText",
      :type => "",
      :monitor_json => "MyText",
      :user => nil
    ))
  end

  it "renders the edit ragios_monitor form" do
    render

    assert_select "form[action=?][method=?]", ragios_monitor_path(@ragios_monitor), "post" do

      assert_select "input#ragios_monitor_title[name=?]", "ragios_monitor[title]"

      assert_select "textarea#ragios_monitor_description[name=?]", "ragios_monitor[description]"

      assert_select "input#ragios_monitor_url[name=?]", "ragios_monitor[url]"

      assert_select "input#ragios_monitor_duration[name=?]", "ragios_monitor[duration]"

      assert_select "input#ragios_monitor_contact[name=?]", "ragios_monitor[contact]"

      assert_select "input#ragios_monitor_ragiosid[name=?]", "ragios_monitor[ragiosid]"

      assert_select "input#ragios_monitor_string[name=?]", "ragios_monitor[string]"

      assert_select "textarea#ragios_monitor_code[name=?]", "ragios_monitor[code]"

      assert_select "input#ragios_monitor_type[name=?]", "ragios_monitor[type]"

      assert_select "textarea#ragios_monitor_monitor_json[name=?]", "ragios_monitor[monitor_json]"

      assert_select "input#ragios_monitor_user_id[name=?]", "ragios_monitor[user_id]"
    end
  end
end
