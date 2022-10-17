# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('events/index', type: :view) do
  before do
    view.lookup_context.prefixes << 'application'
    assign(:events, [
      Event.create!(
        event_name: 'Event Name',
        description: 'MyText',
        passcode: 'Passcode',
        date: Time.zone.now,
        points: 2
      ),
      Event.create!(
        event_name: 'Event Name',
        description: 'MyText',
        passcode: 'Passcode',
        date: Time.zone.now + 10.days,
        points: 2
      ),
      Event.create!(
        event_name: 'Event Name',
        description: 'MyText',
        passcode: 'Passcode',
        date: Time.zone.now - 10.days,
        points: 2
      )
    ]
    )

    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
    @past_events = Event.order('date DESC').where('date < ?', Time.zone.now.beginning_of_day)
  end

  it 'renders a list of events' do
    render
    assert_select 'h2', text: 'Event Name'.to_s, count: 3
    assert_select 'p', text: 'MyText'.to_s, count: 3
    assert_select 'p', text: 'Password: Passcode'.to_s, count: 3
  end
end
