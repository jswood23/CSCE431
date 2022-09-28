require 'rails_helper'

RSpec.describe "permissions/index", type: :view do
  before(:each) do
    assign(:permissions, [
      Permission.create!(
        uid: 2,
        admin: false,
        member: false,
        alumni: false
      ),
      Permission.create!(
        uid: 2,
        admin: false,
        member: false,
        alumni: false
      )
    ])
  end

  it "renders a list of permissions" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
