require 'rails_helper'

RSpec.describe "ragios_monitors/show", type: :view do
  before(:each) do
    @ragios_monitor = assign(:ragios_monitor, RagiosMonitor.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Contact/)
    expect(rendered).to match(/Ragiosid/)
    expect(rendered).to match(/String/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
