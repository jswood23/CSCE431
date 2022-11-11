# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('events/index', type: :view) do
  before do
    view.lookup_context.prefixes << 'application'
    without_partial_double_verification do
      allow(view).to(receive(:get_points_type).and_return('Member'))
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

    @points_types = PointsType.all.order('id ASC')
    @events_today = Event.where(date: Time.zone.today.all_day)
    @upcoming_events = Event.order('date ASC').where('date > ?', Time.zone.now.end_of_day)
    @past_events = Event.order('date DESC').where('date < ?', Time.zone.now.beginning_of_day)
  end

  it 'renders a list of events' do
    render
    assert_select 'h1', text: 'Event Name'.to_s, count: 3
    assert_select 'p', text: 'MyText'.to_s, count: 3
  end
end
