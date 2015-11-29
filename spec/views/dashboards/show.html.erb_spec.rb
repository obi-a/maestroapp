require 'rails_helper'

RSpec.describe "dashboards/show", type: :view do
  before(:each) do
    @dashboard = assign(:dashboard, Dashboard.create!(
      :index => "Index"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Index/)
  end
end
