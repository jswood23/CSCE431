require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      event_name: "MyString",
      description: "MyText",
      passcode: "MyString"
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[event_name]"

      assert_select "textarea[name=?]", "event[description]"

      assert_select "input[name=?]", "event[passcode]"
    end
  end
end