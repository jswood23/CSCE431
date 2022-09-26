require 'rails_helper'

RSpec.describe "attendances/edit", type: :view do
  before(:each) do
    @attendance = assign(:attendance, Attendance.create!(
      event_id: 1,
      member_id: 1,
      event_name: "MyString"
    ))
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(@attendance), "post" do

      assert_select "input[name=?]", "attendance[event_id]"

      assert_select "input[name=?]", "attendance[member_id]"

      assert_select "input[name=?]", "attendance[event_name]"
    end
  end
end
