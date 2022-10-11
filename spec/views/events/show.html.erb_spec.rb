require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      event_name: "Event Name",
      description: "MyText",
      passcode: "Passcode",
      points: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Event Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Passcode/)
    expect(rendered).to match(/2/)
  end
end
