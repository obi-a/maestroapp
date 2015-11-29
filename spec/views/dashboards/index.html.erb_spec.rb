require 'rails_helper'

RSpec.describe "dashboards/index", type: :view do
  before(:each) do
    assign(:dashboards, [
      Dashboard.create!(
        :index => "Index"
      ),
      Dashboard.create!(
        :index => "Index"
      )
    ])
  end

  it "renders a list of dashboards" do
    render
    assert_select "tr>td", :text => "Index".to_s, :count => 2
  end
end
