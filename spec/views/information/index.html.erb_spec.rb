require 'rails_helper'

RSpec.describe "information/index", type: :view do
  before(:each) do
    assign(:information, [
      Information.create!(
        uid: 2,
        name: "Name",
        email: "Email",
        position: "Position",
        bios: "MyText",
        phone: "Phone",
        points: 3
      ),
      Information.create!(
        uid: 2,
        name: "Name",
        email: "Email",
        position: "Position",
        bios: "MyText",
        phone: "Phone",
        points: 3
      )
    ])
  end

  it "renders a list of information" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Position".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
