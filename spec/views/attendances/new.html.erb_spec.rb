require 'rails_helper'

RSpec.describe "attendances/new", type: :view do
  before(:each) do
    assign(:attendance, Attendance.new(
      event_id: 1,
      member_id: 1,
      event_name: "MyString"
    ))
  end

  it "renders new attendance form" do
    render

    assert_select "form[action=?][method=?]", attendances_path, "post" do

      assert_select "input[name=?]", "attendance[event_id]"

      assert_select "input[name=?]", "attendance[member_id]"

      assert_select "input[name=?]", "attendance[event_name]"
    end
  end
end
