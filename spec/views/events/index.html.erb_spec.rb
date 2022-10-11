require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        event_name: "Event Name",
        description: "MyText",
        passcode: "Passcode",
        date: Time.now,
        points: 2
      ),
      Event.create!(
        event_name: "Event Name",
        description: "MyText",
        passcode: "Passcode",
        date: Time.now,
        points: 2
      )
    ])
    
    @upcoming_events = Event.order('date ASC').where("date >= ?", Time.now)
    @past_events = Event.order('date DESC').where("date < ?", Time.now)
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: "Event Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Passcode".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
