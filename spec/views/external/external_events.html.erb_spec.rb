# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('external/events', type: :view) do
  before do
    without_partial_double_verification do
      allow(view).to(receive(:get_points_type).and_return('Member'))
      allow(view).to(receive(:convert_line_breaks).and_return('<p>MyText</p>'.html_safe))
    end
    assign(:events, [
      Event.create!(
        event_name: 'Event Name',
        description: 'MyText',
        passcode: 'Passcode',
        date: Time.zone.now,
        points: 2,
        points_type_id: 1
      ),
      Event.create!(
        event_name: 'Event Name',
        description: 'MyText',
        passcode: 'Passcode',
        date: Time.zone.now + 10.days,
        points: 2,
        points_type_id: 1
      ),
      Event.create!(
        event_name: 'Event Name',
        description: 'MyText',
        passcode: 'Passcode',
        date: Time.zone.now - 10.days,
        points: 2,
        points_type_id: 1
      )
    ]
    )
    assign(:events_today, Event.where(date: Time.zone.today.all_day))
    assign(:points_types, PointsType.all.order('id ASC'))
    assign(:upcoming_events, Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day))
  end

  it 'renders a list of events' do
    render
    assert_select 'h1', text: 'Event Name'.to_s, count: 2
    assert_select 'p', text: 'MyText'.to_s, count: 3
  end

  it 'assigns @events_today' do
    expect(:events_today).not_to(be_nil)
  end

  it 'assigns @upcoming_events' do
    expect(:upcoming_events).not_to(be_nil)
  end
end
